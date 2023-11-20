#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Add helm repository
helm repo add grafana https://grafana.github.io/helm-charts

# Update helm repositories
helm repo update

# Create namespace loki if not exists
kubectl create namespace loki --dry-run=client -o yaml | kubectl apply -f -

# Install grafana
helm -n loki upgrade --install loki grafana/loki \
    -f ${SCRIPT_DIR}/helm/loki-values.yaml

# Install promtail
helm -n loki upgrade --install promtail grafana/promtail

