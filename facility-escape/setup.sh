#!/bin/bash
set -e

echo "=================================="
echo "Preparing Haunted Kubernetes Escape Room"
echo "=================================="

kubectl create namespace haunted-facility \
  --dry-run=client -o yaml | kubectl apply -f -

BASE_URL="https://raw.githubusercontent.com/kubecheal/haunted-kubernetes-escape-room/main/facility-escape/manifests"

for file in namespace.yaml deployment.yaml service.yaml
do
    echo "Downloading $file..."
    curl -fsSLO "$BASE_URL/$file"
done

echo "Applying manifests..."

kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo ""
echo "✅ Environment Ready!"
