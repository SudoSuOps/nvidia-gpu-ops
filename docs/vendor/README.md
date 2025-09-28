# Vendor Snapshots

Local mirrors of critical NVIDIA documentation and manifests. Refresh via `make vendor-sync`.

| Component | Source | Local Path |
| --- | --- | --- |
| GPU Operator | https://github.com/NVIDIA/gpu-operator | `docs/vendor/gpu-operator/` |
| Container Toolkit | https://docs.nvidia.com/datacenter/cloud-native/container-toolkit | `docs/vendor/container-toolkit/` |
| Driver/CUDA matrix | https://docs.nvidia.com/datacenter/tesla/drivers | `docs/vendor/compatibility/` |
| Troubleshooting | https://docs.nvidia.com/datacenter/cloud-native/kubernetes/pdf | `docs/vendor/troubleshooting/` |

## Sync Workflow

1. Update desired version in `scripts/vendor-sync.sh`.
2. Run `make vendor-sync`.
3. Review diffs, commit with message `Update NVIDIA vendor docs <component> <version>`.
