#!/bin/bash

kubectl -n cnpg delete cluster/postgis-cluster

helm uninstall cnpg \
  --namespace cnpg
