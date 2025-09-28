#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$REPO_ROOT/docs/vendor/gpu-operator"
mkdir -p "$REPO_ROOT/docs/vendor/container-toolkit"

echo "[*] Sync GPU Operator docs"
curl -sL https://raw.githubusercontent.com/NVIDIA/gpu-operator/main/README.md > "$REPO_ROOT/docs/vendor/gpu-operator/README.md"

echo "[*] Sync Container Toolkit docs"
curl -sL https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html > "$REPO_ROOT/docs/vendor/container-toolkit/install-guide.html"

echo "[*] Vendor sync complete"
