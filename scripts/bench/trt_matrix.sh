#!/usr/bin/env bash
set -euo pipefail

IMG="nvcr.io/nvidia/tensorrt:24.06-py3"
MODEL_DIR="$PWD/sample_models/resnet50"
MODEL_ONNX="$MODEL_DIR/ResNet50.onnx"

mkdir -p "$MODEL_DIR"
if [[ ! -f "$MODEL_ONNX" ]]; then
  echo "[*] Downloading ResNet50 ONNX..."
  curl -L -o "$MODEL_ONNX" https://github.com/onnx/models/raw/main/vision/classification/resnet/model/resnet50-v2-7.onnx
fi

PRECISIONS=(fp8 fp16 int8)

for PREC in "${PRECISIONS[@]}"; do
  echo "=== Running ResNet50 benchmark with $PREC ==="
  docker run --rm --gpus all \
    -v "$PWD":/workspace -w /workspace \
    "$IMG" \
    bash -lc "trtexec \
      --onnx=/workspace/sample_models/resnet50/ResNet50.onnx \
      --explicitBatch \
      --shapes=input:1x3x224x224 \
      --$PREC \
      --avgRuns=50 \
      --duration=20 \
      --verbose" \
    | tee "bench_resnet50_${PREC}.log"
done

echo "=== Done. Logs saved to bench_resnet50_{fp8,fp16,int8}.log ==="
