#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}

# Create namespace whoami if not exists
kubectl create namespace whoami --dry-run=client -o yaml | kubectl apply -f -

# Deploy traefik with helm
kubectl -n whoami apply -k manifest/base

# Create IngressRoute with dynamic hostname
cat <<EOF | kubectl -n whoami apply -f -
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: whoami
spec:
  entryPoints:
    - web
    - websecure
  routes:
    - match: Host(\`whoami.$DEVBOX_HOSTNAME\`)
      kind: Rule
      services:
        - name: whoami
          port: 80
EOF
