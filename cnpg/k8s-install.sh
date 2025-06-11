#!/bin/bash

echo "---------------------------------------------"
echo "-- cnpg/k8s-install.sh"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi


helm repo add cnpg https://cloudnative-pg.github.io/charts

helm repo update

helm upgrade --install cnpg \
  --namespace cnpg \
  --create-namespace \
  cnpg/cloudnative-pg

# Wait for cert-manager pods to be ready
kubectl -n cnpg wait \
    --for=condition=ready pod \
    --selector=app.kubernetes.io/name=cloudnative-pg \
    --timeout=90s

#kubectl -n cnpg apply -f "${SCRIPT_DIR}/manifest/postgis-cluster.yaml"
#kubectl -n cnpg apply -f "${SCRIPT_DIR}/manifest/postgis-cluster.yaml"