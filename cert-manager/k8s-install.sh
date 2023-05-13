#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Create namespace cert-manager if not exists
kubectl create namespace cert-manager --dry-run=client -o yaml | kubectl apply -f -

# Deploy cert-manager with helm
helm -n cert-manager upgrade --install cert-manager \
  oci://registry-1.docker.io/bitnamicharts/cert-manager \
  --set installCRDs=true


