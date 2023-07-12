#!/bin/bash

echo "---------------------------------------------"
echo "-- cert-manager/k8s-install.sh"
echo "---------------------------------------------"

# Create namespace cert-manager if not exists
kubectl create namespace cert-manager --dry-run=client -o yaml | kubectl apply -f -

# Deploy cert-manager with helm
helm -n cert-manager upgrade --install cert-manager \
  oci://registry-1.docker.io/bitnamicharts/cert-manager \
  --set installCRDs=true

kubectl wait --namespace cert-manager \
    --for=condition=ready pod \
    --selector=app.kubernetes.io/name=cert-manager \
    --timeout=90s
