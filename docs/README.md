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
