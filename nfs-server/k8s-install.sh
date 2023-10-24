#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Create namespace nfs if not exists
kubectl create namespace nfs-system --dry-run=client -o yaml | kubectl apply -f -

# Deploy nfs-server with kustomize
kubectl -n nfs-system apply -k ${SCRIPT_DIR}/manifest
