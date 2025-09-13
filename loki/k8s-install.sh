#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "---------------------------------------------"
echo "-- loki/k8s-install.sh"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi


# Add helm repository
helm repo add grafana https://grafana.github.io/helm-charts

# Update helm repositories
helm repo update

# helm search repo grafana/loki
# NAME                            CHART VERSION   APP VERSION
# grafana/loki                    6.38.0          3.5.3
LOKI_CHART_VERSION=6.38.0

# Create namespace loki if not exists
kubectl create namespace loki --dry-run=client -o yaml | kubectl apply -f -

# Install grafana
helm -n loki upgrade --install loki \
  grafana/loki --version=$LOKI_CHART_VERSION \
  -f ${SCRIPT_DIR}/helm/loki/values.yaml

# Install promtail
helm -n loki upgrade --install promtail grafana/promtail

