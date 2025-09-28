#!/usr/bin/env bash
set -euo pipefail

IMG="nvcr.io/nvidia/tensorrt:24.06-py3"

for PREC in fp8 fp16 int8; do
  echo "=== Running ResNet50 with $PREC ==="
  docker run --rm --gpus all -v "$PWD":/workspace -w /workspace "$IMG" \
    bash -lc "trtexec --onnx=/workspace/sample_models/resnet50/ResNet50.onnx \
      --explicitBatch --shapes=input:1x3x224x224 \
      --$PREC --avgRuns=50 --duration=20"
done
