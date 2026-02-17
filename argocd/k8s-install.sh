#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-selfsigned}

echo "---------------------------------------------"
echo "-- argocd/k8s-install.sh"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Create namespace argocd if not exists
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

# Deploy ArgoCD with Kustomize
# https://argo-cd.readthedocs.io/en/stable/getting_started/
kubectl -n argocd apply --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Create IngressRoute with dynamic hostname
# adapted from https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#ssl-passthrough-with-cert-manager-and-lets-encrypt
cat <<EOF | kubectl -n argocd apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: argocd-server
  namespace: argocd
  annotations:
    cert-manager.io/cluster-issuer: ${DEVBOX_ISSUER}
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: argocd.${DEVBOX_HOSTNAME}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: argocd-server
            port:
              name: https
  tls:
  - hosts:
    - argocd.${DEVBOX_HOSTNAME}
    secretName: argocd-server-tls # as expected by argocd-server
EOF
