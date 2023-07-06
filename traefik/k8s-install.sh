#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
# allows to switch to kind
TRAEFIK_MODE=${TRAEFIK_MODE:-local}

# Add helm repository
helm repo add traefik https://helm.traefik.io/traefik

# Update helm repositories
helm repo update

# Create namespace traefik-system if not exists
kubectl create namespace traefik-system --dry-run=client -o yaml | kubectl apply -f -

# Deploy traefik with helm
helm -n traefik-system upgrade --install -f helm/${TRAEFIK_MODE}.yml traefik traefik/traefik

# Create IngressRoute with dynamic hostname
cat <<EOF | kubectl -n traefik-system apply -f -
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: dashboard
spec:
  entryPoints:
    - web
    - websecure
  routes:
    - match: Host(\`traefik.$DEVBOX_HOSTNAME\`)
      kind: Rule
      services:
        - name: api@internal
          kind: TraefikService
EOF