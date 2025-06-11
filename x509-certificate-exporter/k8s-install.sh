#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "---------------------------------------------"
echo "-- x509-certificate-exporter"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Create namespace x509-certificate-exporter if not exists
kubectl create namespace x509-certificate-exporter --dry-run=client -o yaml | kubectl apply -f -

# Configure a NetworkPolicy to ensure that only prometheus has access to this namespace
# TODO : fix issue with egress-allow-apiserver under kind/calico
# kubectl -n x509-certificate-exporter apply -f "${SCRIPT_DIR}/manifest/network-policy.yml"

# Deploy x509-certificate-exporter
helm repo add enix https://charts.enix.io
helm repo update
helm upgrade --install x509-certificate-exporter enix/x509-certificate-exporter \
    --namespace x509-certificate-exporter \
    -f "${SCRIPT_DIR}/helm/values.yaml"

