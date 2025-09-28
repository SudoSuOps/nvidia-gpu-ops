SHELL := /bin/bash
INV := ansible/inventory/hosts.ini

.PHONY: prep runtime reboot verify verify-smi verify-pytorch verify-trt bench-burn opt-persistence operator smoke vendor-sync

prep:
	ansible-playbook -i $(INV) ansible/playbooks/01-prereqs.yml

runtime:
	ansible-playbook -i $(INV) ansible/playbooks/02-runtime.yml

reboot:
	ansible -i $(INV) gpu_hosts -b -m reboot

verify: verify-smi verify-pytorch verify-trt

verify-smi:
	scripts/verify/nvidia_smi.sh

verify-pytorch:
	scripts/verify/pytorch_cuda_ok.sh

verify-trt:
	scripts/verify/trtexec_resnet50.sh

bench-burn:
	scripts/bench/gpu_burn_docker.sh

opt-persistence:
	scripts/opt/persistence_on.sh

operator:
	ansible-playbook -i $(INV) ansible/playbooks/03-gpu-operator.yml

smoke:
	kubectl delete pod gpu-smoke-test --ignore-not-found || true
	kubectl apply -f kubernetes/manifests/gpu-smoke-test.yaml
	kubectl wait --for=condition=Ready pod/gpu-smoke-test --timeout=180s || true
	kubectl logs gpu-smoke-test || true

vendor-sync:
	scripts/vendor-sync.sh

dcgm-exporter:
	helm repo add nvidia https://nvidia.github.io/dcgm-exporter || true
	helm repo update
	helm upgrade --install dcgm-exporter nvidia/dcgm-exporter \
	  -n monitoring --create-namespace \
	  -f kubernetes/values/dcgm-exporter.yaml
