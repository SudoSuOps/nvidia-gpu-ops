# NVIDIA Upstream Reference Sources

| Component | Source / Docs | What to Capture / Mirror | Usage in Repo |
| --- | --- | --- | --- |
| GPU Operator (Kubernetes) | [NVIDIA/gpu-operator](https://github.com/NVIDIA/gpu-operator)  
[Installing the NVIDIA GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html) | Chart templates, CRD specs, version compatibility tables, Helm options | Store versioned copies under `docs/vendor/gpu-operator/<version>/`; include README excerpts |
| NVIDIA Container Toolkit | [Installing the NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) | Repo setup instructions, config examples, containerd integration | Mirror key sections in `docs/vendor/container-toolkit/`; keep install steps in scripts |
| CUDA / Driver Install | [CUDA Installation Guide for Linux](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/)  
[Ubuntu driver guide](https://www.ipserverone.info/knowledge-base/installing-nvidia-gpu-driver-on-ubuntu-a-step-by-step-guide/) | Supported driver/CUDA combinations, kernel module workflows | Capture matrices in `docs/vendor/compatibility/`; reference for role defaults |
| Platform Support & Compatibility | [GPU Operator Platform Support](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/platform-support.html) | GPU models, OS/K8s version compatibility, MIG notes | Maintain `docs/vendor/compatibility/platform-support.md` for quick lookup |
| Troubleshooting | [GPU Operator Troubleshooting](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/troubleshooting.html) | Known pitfalls, diagnostics commands | Integrate into `docs/runbooks/troubleshooting.md` with upstream references |

Refresh these sources via `scripts/vendor-sync.sh` and commit updates with messages like `Update NVIDIA vendor docs <component> <version>`.
