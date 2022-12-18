#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}

# Create namespace adminer if not exists
kubectl create namespace adminer --dry-run=client -o yaml | kubectl apply -f -

# Deploy traefik with helm
kubectl -n adminer apply -k manifest/base

# Create Ingress with dynamic hostname
cat <<EOF | kubectl -n adminer apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: adminer
spec:
  rules:
  - host: adminer.$DEVBOX_HOSTNAME
    http:
      paths:
      - backend:
          service:
            name: adminer
            port:
              number: 8080
        path: /
        pathType: Exact
EOF
