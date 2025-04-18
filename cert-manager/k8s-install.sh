#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "---------------------------------------------"
echo "-- cert-manager/k8s-install.sh"
echo "---------------------------------------------"

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

# Create self-signed cluster issuer
bash "$SCRIPT_DIR/cluster-issuer/selfsigned.sh"

# Create mkcert issuer if available
if which mkcert >/dev/null; then
  bash "$SCRIPT_DIR/cluster-issuer/mkcert.sh"
else
  echo "mkcert not found, skip ClusterIssuer creation"
fi
