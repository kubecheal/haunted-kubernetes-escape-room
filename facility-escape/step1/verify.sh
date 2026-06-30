#!/bin/bash

SERVICE_SELECTOR=$(kubectl get svc frontend \
  -n haunted-facility \
  -o jsonpath='{.spec.selector.app}')

if [ "$SERVICE_SELECTOR" != "frontend" ]; then
    echo "❌ The Service selector is still incorrect."
    exit 1
fi

ENDPOINTS=$(kubectl get endpoints frontend \
  -n haunted-facility \
  -o jsonpath='{.subsets[*].addresses[*].ip}')

if [ -z "$ENDPOINTS" ]; then
    echo "❌ The Service still has no endpoints."
    exit 1
fi

echo "✅ Reception Desk restored!"
exit 0
