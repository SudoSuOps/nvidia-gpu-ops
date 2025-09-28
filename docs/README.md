# NVIDIA GPU Ops — Blackwell-Ready

Gold-standard playbooks and scripts to stand up NVIDIA GPU infrastructure.

## Stack Coverage

* Host drivers (`nvidia-driver-580-open` default) + CUDA 13.x toolkit
* Container runtime (containerd) with NVIDIA container toolkit + CDI
* Optional DCGM userspace
* Kubernetes GPU Operator (host drivers, toolkit enabled)
* Verification workflows (nvidia-smi, PyTorch CUDA, TensorRT)
* Benchmarks and burn-in (gpu-burn)
* Optimization hooks (persistence, MIG templates)

## Daily Flow

```bash
# onboard host
vim ansible/inventories/site/inventory.ini

make prep
make runtime
make reboot

# verify
make verify

# optional GPU Operator
make operator
make smoke

# stress + persistence
make bench-burn
make opt-persistence
```

## Repository Layout

| Path | Description |
| --- | --- |
| `ansible/` | Inventory, playbooks, roles |
| `scripts/verify` | CUDA/TensorRT sanity checks |
| `scripts/bench` | Stress/burn-in tooling |
| `scripts/opt` | Persistence & MIG helpers |
| `monitoring/` | Prometheus & Grafana config stubs |
| `docs/` | Architecture, runbooks, vendor mirrors |

## Next Steps

- Wire CI for ansible-lint and shellcheck
- Populate vendor snapshots in `docs/vendor/`
- Add Grafana dashboards and Prometheus scrape configs under `monitoring/`

## NVIDIA Source Integration

We keep upstream references versioned locally:

1. **Vendor snapshots** – mirror specific releases into `docs/vendor/<component>/<version>/` (e.g., GPU Operator `v25.3.4`).
2. **Git submodules** – optionally track `NVIDIA/gpu-operator` under `third_party/` for upstream diffs (`git submodule update --remote`).
3. **Automated doc sync** – run `scripts/vendor-sync.sh` (used by `make vendor-sync`) to pull install guides, compatibility tables, and troubleshooting docs.
4. **Cross-reference** – every mirrored doc links back to the official NVIDIA source and retains licensing disclaimers.

Example GPU Operator install (excerpted from NVIDIA docs):

```bash
helm repo add nvidia https://helm.ngc.nvidia.com/nvidia
helm repo update
helm install --wait --generate-name \
  -n gpu-operator --create-namespace \
  nvidia/gpu-operator --version=v25.3.4

# Skip driver deployment when host drivers are managed externally
helm install \
  --set driver.enabled=false \
  nvidia/gpu-operator ...
```

Always consult the [official NVIDIA GPU Operator documentation](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html) for latest options and compatibility matrices.
