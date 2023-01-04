#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD:-ChangeIt}

# Add helm repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# Update helm repositories
helm repo update

# Create namespace minio-system if not exists
kubectl create namespace minio-system --dry-run=client -o yaml | kubectl apply -f -

# Deploy minio with helm
helm -n minio-system upgrade --install minio bitnami/minio \
  --set auth.rootPassword=$MINIO_ROOT_PASSWORD \
  --set ingress.enabled=true \
  --set ingress.hostname=minio.$DEVBOX_HOSTNAME \
  --set apiIngress.enabled=true \
  --set apiIngress.hostname=minio-s3.$DEVBOX_HOSTNAME
