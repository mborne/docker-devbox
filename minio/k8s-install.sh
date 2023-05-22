#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-mkcert}

MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD:-ChangeIt}

# Add helm repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# Update helm repositories
helm repo update

# Create namespace minio-system if not exists
kubectl create namespace minio-system --dry-run=client -o yaml | kubectl apply -f -

# Deploy minio with helm
helm -n minio-system upgrade --install minio bitnami/minio -f values.yaml \
  --set auth.rootPassword=$MINIO_ROOT_PASSWORD \
  --set ingress.hostname=minio.$DEVBOX_HOSTNAME \
  --set ingress.ingressClassName=$DEVBOX_INGRESS \
  --set ingress.annotations."cert-manager\.io\/cluster-issuer"=${DEVBOX_ISSUER} \
  --set apiIngress.hostname=minio-s3.$DEVBOX_HOSTNAME \
  --set apiIngress.ingressClassName=$DEVBOX_INGRESS \
  --set apiIngress.annotations."cert-manager\.io\/cluster-issuer"=${DEVBOX_ISSUER}
