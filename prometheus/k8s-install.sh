#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-mkcert}

# Add helm repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# Update helm repositories
helm repo update

# Create namespace prometheus if not exists
kubectl create namespace prometheus --dry-run=client -o yaml | kubectl apply -f -

# Deploy prometheus-operator without grafana
helm upgrade -n prometheus --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  -f ${SCRIPT_DIR}/helm/prometheus-stack/values.yaml

# Deploy prometheus-blackbox-exporter with sample ServiceMonitors
helm upgrade -n prometheus --install prometheus-blackbox-exporter prometheus-community/prometheus-blackbox-exporter \
  -f ${SCRIPT_DIR}/helm/blackbox-exporter/values.yaml

