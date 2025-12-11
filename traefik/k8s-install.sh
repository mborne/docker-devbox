#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-selfsigned}
# allows to switch to kind
TRAEFIK_MODE=${TRAEFIK_MODE:-local}

echo "---------------------------------------------"
echo "-- traefik/k8s-install.sh : "
echo "--   DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME}"
echo "--   DEVBOX_ISSUER=${DEVBOX_ISSUER}"
echo "--   TRAEFIK_MODE=${TRAEFIK_MODE}"
echo "---------------------------------------------"

# Add helm repository
helm repo add traefik https://helm.traefik.io/traefik

# Update helm repositories
helm repo update

# Create namespace traefik-system if not exists
kubectl create namespace traefik-system --dry-run=client -o yaml | kubectl apply -f -

# Deploy traefik with helm
# helm search repo traefik/traefik
CHART_VERSION=37.4.0 # APP_VERSION=v3.6.2
helm -n traefik-system upgrade --install traefik traefik/traefik \
  -f ${SCRIPT_DIR}/helm/${TRAEFIK_MODE}/values.yml \
  --version $CHART_VERSION

# Create Certificate using cert-manager
cat <<EOF | kubectl -n traefik-system apply -f -
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: traefik-cert
spec:
  secretName: traefik-tls
  issuerRef:
    name: ${DEVBOX_ISSUER}
    kind: ClusterIssuer
  dnsNames:
    - traefik.$DEVBOX_HOSTNAME
EOF

# Create IngressRoute with dynamic hostname
cat <<EOF | kubectl -n traefik-system apply -f -
apiVersion: traefik.io/v1alpha1
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
  tls:
    secretName: traefik-tls
EOF


