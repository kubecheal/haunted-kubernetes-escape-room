#!/bin/bash

SELECTOR=$(kubectl get svc frontend \
-n haunted-facility \
-o jsonpath='{.spec.selector.app}')

if [ "$SELECTOR" = "frontend" ]
then
    exit 0
fi

echo "Reception Desk is still broken."

exit 1
