#!/bin/bash
set -e

echo "========================================"
echo "Haunted Kubernetes Escape Room"
echo "Room 1 - Reception Desk"
echo "========================================"

kubectl create namespace haunted-facility \
  --dry-run=client -o yaml | kubectl apply -f -

BASE_URL="https://raw.githubusercontent.com/kubecheal/haunted-kubernetes-escape-room/main/facility-escape/manifests"

FILES=(
  namespace.yaml
  deployment.yaml
  service.yaml
)

echo ""
echo "Downloading manifests..."

for file in "${FILES[@]}"
do
    curl -fsSLO "${BASE_URL}/${file}"
done

echo ""
echo "Deploying environment..."

kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo ""
echo "========================================"
echo "Environment Ready!"
echo ""
echo "The Reception Desk application is offline."
echo "Your task is to restore access."
echo "========================================"
