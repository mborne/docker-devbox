#!/bin/bash

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