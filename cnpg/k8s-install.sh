#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

helm repo add cnpg https://cloudnative-pg.github.io/charts

helm repo update

helm upgrade --install cnpg \
  --namespace cnpg \
  --create-namespace \
  cnpg/cloudnative-pg

kubectl -n cnpg apply -f "${SCRIPT_DIR}/manifest/postgis-cluster.yaml"
