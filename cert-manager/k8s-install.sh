#!/bin/bash

# Create namespace cert-manager if not exists
echo "-- cert-manager - create namespace..."
kubectl create namespace cert-manager --dry-run=client -o yaml | kubectl apply -f -

# Deploy cert-manager with helm
echo "-- cert-manager - deploy with helm..."
helm -n cert-manager upgrade --install cert-manager \
  oci://registry-1.docker.io/bitnamicharts/cert-manager \
  --set installCRDs=true

echo "-- cert-manager - wait for pods..."
kubectl wait --namespace cert-manager \
    --for=condition=ready pod \
    --selector=app.kubernetes.io/name=cert-manager \
    --timeout=90s

echo "-- cert-manager - completed"

