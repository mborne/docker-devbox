#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

helm upgrade --install trivy-operator oci://ghcr.io/aquasecurity/helm-charts/trivy-operator \
    --namespace trivy-system \
    --create-namespace \
    --version 0.25.0 \
    -f "${SCRIPT_DIR}/helm/values.yaml"
