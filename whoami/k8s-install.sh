#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-mkcert}

# Create namespace whoami if not exists
kubectl create namespace whoami --dry-run=client -o yaml | kubectl apply -f -

# Deploy traefik with helm
kubectl -n whoami apply -k ${SCRIPT_DIR}/manifest/base

# Create Ingress with dynamic hostname
cat <<EOF | kubectl -n whoami apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: whoami
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: whoami.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: ImplementationSpecific
        path: "/"
        backend:
          service:
            name: whoami
            port:
              number: 80
  tls:
  - hosts:
    - whoami.$DEVBOX_HOSTNAME
    secretName: whoami-cert
EOF

kubectl wait --namespace whoami \
    --for=condition=ready pod \
    --selector=app=whoami \
    --timeout=90s

# Display resources
kubectl -n whoami get pods,svc,ingress
