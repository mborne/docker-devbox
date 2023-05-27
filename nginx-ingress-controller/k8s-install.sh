#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}

# Create namespace nginx-system if not exists
kubectl create namespace nginx-system --dry-run=client -o yaml | kubectl apply -f -

# Deploy traefik with helm
helm -n nginx-system upgrade --install nginx \
  oci://registry-1.docker.io/bitnamicharts/nginx-ingress-controller

