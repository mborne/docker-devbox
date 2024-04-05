#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR

# Add helm repository
helm repo add kyverno https://kyverno.github.io/kyverno/

# Update helm repositories
helm repo update

# Create namespace kyverno if not exists
kubectl create namespace kyverno --dry-run=client -o yaml | kubectl apply -f -

# Install kyverno
helm -n kyverno upgrade --install kyverno kyverno/kyverno \
    -f ${SCRIPT_DIR}/helm/kyverno/values.yaml

# Install kyverno-policies (after due to CRDs)
helm -n kyverno upgrade --install kyverno-policies kyverno/kyverno-policies \
    -f ${SCRIPT_DIR}/helm/kyverno-policies/values.yaml


