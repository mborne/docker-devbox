#!/bin/bash

echo "------------------------------------------------------------"
echo "-- cert-manager/cluster-issuer/letsencrypt-cloudflare.sh"
echo "------------------------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}

if [ -z "$CLOUDFLARE_EMAIL" ];
then
    echo "CLOUDFLARE_EMAIL is required"
    exit 1
fi

if [ -z "$CLOUDFLARE_API_KEY" ];
then
  echo "CLOUDFLARE_API_KEY is required"
  exit 1
fi

cat <<EOF | kubectl -n cert-manager apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: cloudflare-api-token-secret
type: Opaque
stringData:
  api-token: ${CLOUDFLARE_API_TOKEN}
EOF

# Create mkcert ClusterIssuer
cat <<EOF | kubectl -n cert-manager apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-cloudflare
spec:
  acme:
    email: ${CLOUDFLARE_EMAIL}
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-cloudflare
    solvers:
    - dns01:
        cloudflare:
          apiTokenSecretRef:
            name: cloudflare-api-token-secret
            key: api-token
EOF
