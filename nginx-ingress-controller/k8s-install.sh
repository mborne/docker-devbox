#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
NGINX_MODE=${NGINX_MODE:-local}

echo "---------------------------------------------"
echo "-- nginx-ingress-controller"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Create namespace nginx-system if not exists
kubectl create namespace nginx-system --dry-run=client -o yaml | kubectl apply -f -

# Deploy traefik with helm
helm -n nginx-system upgrade --install nginx \
  oci://registry-1.docker.io/bitnamicharts/nginx-ingress-controller \
  -f ${SCRIPT_DIR}/helm/${NGINX_MODE}.yml

