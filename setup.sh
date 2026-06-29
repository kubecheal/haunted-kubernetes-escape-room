#!/bin/bash

echo "Preparing Haunted Kubernetes Escape Room..."

kubectl create ns haunted-facility --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f manifests/

echo
echo "Environment Ready."
