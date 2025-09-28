# NVIDIA GPU Ops (Gold Standard)

Operational toolkit for provisioning, validating, and running NVIDIA GPU infrastructure the Minechain way. Everything is Linux-first, automation-driven, and battle tested on RTX 5090-class rigs.

## Daily Flow

```bash
# 1. onboard host
edit ansible/inventory/hosts.ini

# 2. prep + runtime install + reboot
make prep
make runtime
make reboot

# 3. verify CUDA + TensorRT + PyTorch smoke
make verify

# 4. (optional) install GPU Operator + run k8s smoke tests
make operator
make smoke

# 5. stress / burn-in
make bench-burn

# 6. persistence & tuning (MIG, persistence mode, nvidia-persistenced)
make opt-persistence
```

Everything above maps to scripts under `scripts/` and Ansible playbooks in `ansible/`.

## Repository Layout

| Path | Purpose |
| --- | --- |
| `ansible/` | Inventory, playbooks, and roles for driver + toolkit + runtime bootstrap |
| `terraform/` | IaC modules for GPU hosts or supporting infra |
| `scripts/` | CLI helpers invoked by the Makefile targets |
| `monitoring/` | Prometheus + Grafana config, exporters, dashboards |
| `docs/` | Architecture, runbooks, vendor mirrors, SOPs |
| `.github/workflows/` | CI (lint, doc sync) |

## Extras (opt-in)

Ping when you want these wired in and we’ll add them:

* Ansible facts guard (fail when no GPU detected)
* Per-GPU driver pinning for legacy cards
* NVIDIA Grafana/DCGM exporter Helm stack
* TensorRT/ONNX benchmarking matrix for Blackwell (FP8/FP16/INT8)

## NVIDIA Source Integration

We mirror upstream NVIDIA references in `docs/vendor/` (GPU Operator, Container Toolkit, driver compatibility, troubleshooting). Use `make vendor-sync` to refresh snapshots.

## License

Apache-2.0 (unless overridden later). Update once legal confirms.
