#!/usr/bin/env bash
set -euo pipefail

GITHUB_USER="${GITHUB_USER:-SudoSuOps}"
REPO_NAME="${REPO_NAME:-nvidia-gpu-ops}"
REPO_DIR="${REPO_DIR:-$HOME/workspace/$REPO_NAME}"

echo "[*] Installing prerequisites"
sudo apt-get update -y
sudo apt-get install -y git curl wget jq python3-pip make software-properties-common

if ! command -v helm >/dev/null 2>&1; then
  curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
fi

python3 -m pip install --upgrade pip
python3 -m pip install "ansible>=9.0.0" jinja2 paramiko netaddr cryptography ansible-lint

mkdir -p "$(dirname "$REPO_DIR")"
if [[ ! -d "$REPO_DIR/.git" ]]; then
  git clone "git@github.com:${GITHUB_USER}/${REPO_NAME}.git" "$REPO_DIR"
fi

cd "$REPO_DIR"

echo "[*] Running prep + runtime"
make prep || true
make runtime || true

echo "[*] Bootstrap complete"
