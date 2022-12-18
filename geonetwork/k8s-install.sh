#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}

# Create namespace geonetwork if not exists
kubectl create namespace geonetwork --dry-run=client -o yaml | kubectl apply -f -

# Deploy traefik with helm
kubectl -n geonetwork apply -k manifest/base

# Create IngressRoute with dynamic hostname
cat <<EOF | kubectl -n geonetwork apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: geonetwork
spec:
  rules:
  - host: geonetwork.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: geonetwork
            port:
              number: 8080
EOF
