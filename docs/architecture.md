# NVIDIA GPU Ops Architecture

## Layers

1. **Provisioning (Terraform + Ansible)**
   * Terraform modules stand up GPU hosts or cloud nodes.
   * Ansible roles handle OS hardening, driver install, CUDA toolkit, container runtime.

2. **Runtime Tooling**
   * Scripts invoked via Make targets (`prep`, `runtime`, `verify`, etc.).
   * Optional GPU Operator deployment for Kubernetes environments.

3. **Observability**
   * Prometheus scrape configs + DCGM/nvidia-smi exporters.
   * Grafana dashboards for thermals, utilization, MIG profiles.

4. **Benchmark & Validation**
   * TensorRT/ONNX smoke tests, PyTorch CUDA checks, burn-in loops.

5. **Operations & Security**
   * Runbooks (docs/runbooks) cover onboarding, incident response, firmware updates.
   * Security posture enforced via Ansible (SSH hardening, persistence mode, MIG policy).

## Data Flow

```
git push -> CI lint -> make prep/runtime -> Ansible applies driver/toolkit ->
make verify -> metrics emitted to Prometheus -> dashboards & alerts
```

## Integration Points

* **Minechain Miner Stack:** `make opt-persistence` aligns persistence mode & MIG for mining workloads.
* **Kubernetes:** `make operator` deploys vendor GPU Operator manifests via Helm.
* **Fleet Automation:** Ansible inventory drives multi-host rollouts; extend with AWX/Automation Controller if needed.

## TODO

- [ ] Add detailed Terraform module docs
- [ ] Document CI pipelines (lint + doc sync)
- [ ] Include MIG topology examples for Blackwell/Hopper
