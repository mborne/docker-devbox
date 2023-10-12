#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Add helm repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# Update helm repositories
helm repo update

# Create namespace prometheus if not exists
kubectl create namespace prometheus --dry-run=client -o yaml | kubectl apply -f -

# Install prometheus 
helm upgrade -n prometheus --install prometheus prometheus-community/prometheus \
    -f ${SCRIPT_DIR}/helm/values.yaml 
