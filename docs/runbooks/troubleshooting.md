# Troubleshooting

## Post-Install Checks

- Run `nvidia-smi` after driver install; reboot if modules aren’t loaded.
- Confirm `/dev/nvidia*` devices exist; if not, restart `nvidia-persistenced` or reboot.
- Verify container runtime integration:
  ```bash
  sudo nvidia-ctk runtime configure --runtime=containerd --set-as-default
  sudo systemctl restart containerd
  docker run --rm --gpus all nvidia/cuda:12.4.1-base-ubuntu22.04 nvidia-smi
  ```

## Common Issues

| Symptom | Resolution |
| --- | --- |
| `nvidia-smi: command not found` | Ensure driver packages installed; `make runtime` |
| Containers can’t see GPUs | Re-run runtime playbook, ensure `nvidia-container-toolkit` installed |
| GPU Operator pods failing | Check Helm values, look at `kubectl logs -n gpu-operator` |
| MIG commands fail | GPU may not support MIG (consumer cards); check model |

## Tuning / Optimization

- Enable persistence mode: `make opt-persistence`
- Apply MIG templates (datacenter GPUs): see `scripts/opt/mig_templates.md`

## Support Links

- NVIDIA Troubleshooting Guide: https://docs.nvidia.com/datacenter/cloud-native/kubernetes/kubernetes-troubleshooting/index.html
- NVIDIA Driver Docs: https://docs.nvidia.com/datacenter/tesla/drivers
