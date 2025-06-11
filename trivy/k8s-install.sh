#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "---------------------------------------------"
echo "-- trivy"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

helm upgrade --install trivy-operator oci://ghcr.io/aquasecurity/helm-charts/trivy-operator \
    --namespace trivy-system \
    --create-namespace \
    --version 0.25.0 \
    -f "${SCRIPT_DIR}/helm/values.yaml"
