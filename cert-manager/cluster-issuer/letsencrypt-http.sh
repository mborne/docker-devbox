#!/bin/bash

echo "---------------------------------------------"
echo "-- cert-manager/cluster-issuer/letsencrypt-http.sh"
echo "---------------------------------------------"

DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}

if [ -z "$1" ];
then
    echo "Usage: cluster-issuer/letsencrypt-http.sh <CONTACT_EMAIL>"
    exit 1
fi
CONTACT_EMAIL=$1

# Create mkcert ClusterIssuer
cat <<EOF | kubectl -n cert-manager apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-http
spec:
  acme:
    email: ${CONTACT_EMAIL}
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: ${DEVBOX_INGRESS}
EOF
