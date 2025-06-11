#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "---------------------------------------------"
echo "-- nfs-server"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Create namespace nfs if not exists
kubectl create namespace nfs-system --dry-run=client -o yaml | kubectl apply -f -

# Deploy nfs-server with kustomize
kubectl -n nfs-system apply -k ${SCRIPT_DIR}/manifest
