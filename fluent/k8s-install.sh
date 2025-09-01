#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "---------------------------------------------"
echo "-- fluent"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Create namespace fluent if not exists
kubectl create namespace fluent --dry-run=client -o yaml | kubectl apply -f -

# Add fluent repo
helm repo add fluent https://fluent.github.io/helm-charts

# Update repos
helm repo update

# Deploy fluent-bit with helm
helm -n fluent upgrade --install fluent-bit fluent/fluent-bit \
  -f ${SCRIPT_DIR}/helm/fluent-bit/values.yaml





