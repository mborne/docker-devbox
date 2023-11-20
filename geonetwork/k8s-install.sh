#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-mkcert}

# Create namespace geonetwork if not exists
kubectl create namespace geonetwork --dry-run=client -o yaml | kubectl apply -f -

# Deploy traefik with helm
kubectl -n geonetwork apply -k ${SCRIPT_DIR}/manifest/base

# Create IngressRoute with dynamic hostname
cat <<EOF | kubectl -n geonetwork apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: geonetwork
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
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
  tls:
  - hosts:
    - geonetwork.$DEVBOX_HOSTNAME
    secretName: geonetwork-cert
EOF

# Display resources
kubectl -n geonetwork get pods,svc,ingress
