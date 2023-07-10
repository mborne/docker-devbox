#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-mkcert}

# Create namespace adminer if not exists
kubectl create namespace adminer --dry-run=client -o yaml | kubectl apply -f -

# Deploy traefik with helm
kubectl -n adminer apply -k ${SCRIPT_DIR}/manifest/base

# Create Ingress with dynamic hostname
cat <<EOF | kubectl -n adminer apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: adminer
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
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
  tls:
  - hosts:
    - adminer.$DEVBOX_HOSTNAME
    secretName: adminer-cert
EOF

# Display resources
kubectl -n adminer get pods,svc,ingress
