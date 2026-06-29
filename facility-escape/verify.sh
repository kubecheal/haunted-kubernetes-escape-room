#!/bin/bash
PASS=true
SEL=$(kubectl get svc frontend -n escape-room -o jsonpath='{.spec.selector.app}' 2>/dev/null)
[ "$SEL" = "frontend" ] || PASS=false
HOST=$(kubectl get cm app-config -n escape-room -o jsonpath='{.data.DB_HOST}' 2>/dev/null)
[ -n "$HOST" ] || PASS=false
PVC=$(kubectl get pvc app-data -n escape-room -o jsonpath='{.spec.resources.requests.storage}' 2>/dev/null)
[ "$PVC" != "10Gi" ] || PASS=false
SEC=$(kubectl get deploy frontend -n escape-room -o jsonpath='{.spec.template.spec.containers[0].env[0].valueFrom.secretKeyRef.name}' 2>/dev/null)
[ "$SEC" = "db-creds" ] || PASS=false
NP=$(kubectl get netpol backend-ingress -n escape-room -o jsonpath='{.spec.ingress[0].from[0].podSelector.matchLabels.app}' 2>/dev/null)
[ "$NP" = "frontend" ] || PASS=false
$PASS && exit 0 || exit 1
