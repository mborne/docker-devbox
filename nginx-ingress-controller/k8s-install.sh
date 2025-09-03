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

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update

# helm search repo ingress-nginx
# NAME                            CHART VERSION   APP VERSION
# ingress-nginx/ingress-nginx     4.13.2          1.13.2

# Deploy traefik with helm
helm -n nginx-system upgrade --install nginx \
  ingress-nginx/ingress-nginx --version 4.13.2 \
  -f "${SCRIPT_DIR}/helm/${NGINX_MODE}.yml"


  