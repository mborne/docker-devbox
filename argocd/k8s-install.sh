#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}

# Create namespace argocd if not exists
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

# Deploy ArgoCD with Kustomize
kubectl -n argocd apply -k manifest/base

# Create IngressRoute with dynamic hostname
# see https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#traefik-v22
cat <<EOF | kubectl -n argocd apply -f -
# https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#ingressroute-crd
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: argocd-server
  namespace: argocd
spec:
  entryPoints:
    - web
    - websecure
  routes:
    - kind: Rule
      match: Host(\`argocd.$DEVBOX_HOSTNAME\`)
      priority: 10
      services:
        - name: argocd-server
          port: 80
    - kind: Rule
      match: Host(\`argocd.$DEVBOX_HOSTNAME\`) && Headers(\`Content-Type\`, \`application/grpc\`)
      priority: 11
      services:
        - name: argocd-server
          port: 80
          scheme: h2c
EOF
