#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "---------------------------------------------"
echo "-- cert-manager/k8s-install.sh"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Create namespace cert-manager if not exists
kubectl create namespace cert-manager --dry-run=client -o yaml | kubectl apply -f -

# Deploy cert-manager with helm
helm -n cert-manager upgrade --install cert-manager \
  oci://registry-1.docker.io/bitnamicharts/cert-manager \
  --set installCRDs=true

# Wait for cert-manager pods to be ready
kubectl -n cert-manager wait \
    --for=condition=ready pod \
    --selector=app.kubernetes.io/name=cert-manager \
    --timeout=90s

# Wait for cert-manager CRD to be ready
kubectl wait --for condition=established --timeout=60s crd/clusterissuers.cert-manager.io
kubectl wait --for condition=established --timeout=60s crd/issuers.cert-manager.io
kubectl wait --for condition=established --timeout=60s crd/certificates.cert-manager.io

# Create selfsigned ClusterIssuer
kubectl -n cert-manager apply -f "$SCRIPT_DIR/cluster-issuer/selfsigned.yml"
