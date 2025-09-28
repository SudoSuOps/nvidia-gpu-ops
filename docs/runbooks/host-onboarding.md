# Runbook: GPU Host Onboarding

## Preconditions

- Fresh Ubuntu 22.04/24.04 install
- SSH access with sudo
- Network access to NVIDIA repos & container registries

## Steps

1. **Add host to inventory**
   ```bash
   vim ansible/inventory/hosts.ini
   ```

2. **Prep OS**
   ```bash
   make prep TARGET=<hostname>
   ```

3. **Install runtime**
   ```bash
   make runtime TARGET=<hostname>
   ```

4. **Reboot**
   ```bash
   make reboot TARGET=<hostname>
   ```

5. **Verify stack**
   ```bash
   make verify TARGET=<hostname>
   ```

6. **Optional: Deploy GPU Operator**
   ```bash
   make operator TARGET=<hostname>
   make smoke TARGET=<hostname>
   ```

7. **Burn-in**
   ```bash
   make bench-burn TARGET=<hostname>
   ```

8. **Persistence + MIG**
   ```bash
   make opt-persistence TARGET=<hostname>
   ```

## Validation Checklist

- [ ] `nvidia-smi` shows expected GPUs and driver version
- [ ] PyTorch CUDA check passes (`python3 scripts/tests/torch_cuda_check.py`)
- [ ] TensorRT sample runs without errors
- [ ] Prometheus exporter reachable (if enabled)
- [ ] MIG profiles applied (if required)
