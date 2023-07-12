#!/bin/bash

echo "---------------------------------------------"
echo "-- cert-manager/cluster-issuer/mkcert.sh"
echo "---------------------------------------------"

if which mkcert >/dev/null; then
    echo "Found mkcert ..."
else
    echo "mkcert not found, see :"
    echo "- https://github.com/FiloSottile/mkcert#mkcert and follow instruction"
    echo "- or https://github.com/FiloSottile/mkcert/releases/latest to get binary file"
    exit 1
fi

# see https://cert-manager.io/docs/configuration/ca/
MKCERT_CAROOT=$(mkcert -CAROOT)
MKCERT_CA_CRT=$(cat $MKCERT_CAROOT/rootCA.pem | base64 -w0)
MKCERT_CA_KEY=$(cat $MKCERT_CAROOT/rootCA-key.pem | base64 -w0)

echo "Create secret mkcert-ca from $MKCERT_CAROOT/rootCA.pem and $MKCERT_CAROOT/rootCA-key.pem..."
cat <<EOF | kubectl -n cert-manager apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: mkcert-ca
  namespace: cert-manager
data:
  tls.crt: $MKCERT_CA_CRT
  tls.key: $MKCERT_CA_KEY
EOF

# Create mkcert ClusterIssuer
cat <<EOF | kubectl -n cert-manager apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: mkcert
  namespace: cert-manager
spec:
  ca:
    secretName: mkcert-ca
EOF



