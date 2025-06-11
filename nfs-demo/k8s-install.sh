#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-selfsigned}

echo "---------------------------------------------"
echo "-- nfs-demo"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Create namespace nfs-demo if not exists
kubectl create namespace nfs-demo --dry-run=client -o yaml | kubectl apply -f -

# Deploy nfs-demo with Kustomize
kubectl -n nfs-demo apply -k ${SCRIPT_DIR}/manifest

# Wait for Pods to be ready
kubectl -n nfs-demo wait \
    --for=condition=ready pod \
    --selector=component=server \
    --timeout=60s

# Create Ingress with dynamic hostname
cat <<EOF | kubectl -n nfs-demo apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nfs-demo
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: nfs-demo.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: ImplementationSpecific
        path: "/"
        backend:
          service:
            name: nfs-demo
            port:
              number: 80
  tls:
  - hosts:
    - nfs-demo.$DEVBOX_HOSTNAME
    secretName: nfs-demo-cert
EOF

# Display resources
kubectl -n nfs-demo get pvc,pods,svc,ingress

