#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}

# Create namespace whoami if not exists
kubectl create namespace whoami --dry-run=client -o yaml | kubectl apply -f -

# Deploy traefik with helm
kubectl -n whoami apply -k manifest/base

# Create Ingress with dynamic hostname
cat <<EOF | kubectl -n whoami apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: whoami
spec:
  rules:
  - host: whoami.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: whoami
            port:
              number: 80
EOF
