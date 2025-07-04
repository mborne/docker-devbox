#!/bin/bash

SERVICE_TYPE=${SERVICE_TYPE:-ClusterIp}

echo "---------------------------------------------"
echo "-- postgis"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Create namespace postgis if not exists
kubectl create namespace postgis --dry-run=client -o yaml | kubectl apply -f -

# Create gis-postgresql with bitnami
helm -n postgis upgrade --install gis oci://registry-1.docker.io/bitnamicharts/postgresql \
  --set tls.enabled=true --set tls.autoGenerated=true \
  --set primary.service.type=$SERVICE_TYPE

kubectl -n postgis get secrets gis-postgresql-crt -o jsonpath='{.data.ca\.crt}' | base64 --decode | tee gis-postgresql-ca.crt

