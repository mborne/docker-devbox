#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}

echo "---------------------------------------------"
echo "-- onyxia"
echo "---------------------------------------------"
if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi
if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Create namespace onyxia if not exists
kubectl create namespace onyxia --dry-run=client -o yaml | kubectl apply -f -


helm repo add onyxia https://inseefrlab.github.io/onyxia

helm repo update

helm -n onyxia upgrade --install onyxia onyxia/onyxia -f "$SCRIPT_DIR/helm/values.yaml"
