#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-selfsigned}

MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD:-ChangeIt}

# Add helm repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# Update helm repositories
helm repo update

# Create namespace minio if not exists
kubectl create namespace minio --dry-run=client -o yaml | kubectl apply -f -

# Deploy minio with helm
helm -n minio upgrade --install minio bitnami/minio -f ${SCRIPT_DIR}/helm/minio/values.yaml \
  --set auth.rootPassword=$MINIO_ROOT_PASSWORD \
  --set ingress.hostname=minio.$DEVBOX_HOSTNAME \
  --set ingress.ingressClassName=$DEVBOX_INGRESS \
  --set ingress.annotations."cert-manager\.io\/cluster-issuer"=${DEVBOX_ISSUER} \
  --set apiIngress.hostname=minio-s3.$DEVBOX_HOSTNAME \
  --set apiIngress.ingressClassName=$DEVBOX_INGRESS \
  --set apiIngress.annotations."cert-manager\.io\/cluster-issuer"=${DEVBOX_ISSUER}

# Display resources
kubectl -n minio get pods,svc,ingress
