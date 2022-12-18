#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}

# Add helm repository
helm repo add portainer https://portainer.github.io/k8s

# Update helm repositories
helm repo update

# Create namespace portainer if not exists
kubectl create namespace portainer --dry-run=client -o yaml | kubectl apply -f -

# Deploy portainer with helm
helm -n portainer upgrade --install portainer portainer/portainer

# Create Ingress with dynamic hostname
cat <<EOF | kubectl -n portainer apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: portainer
spec:
  rules:
  - host: portainer.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: portainer
            port:
              number: 9000
EOF
