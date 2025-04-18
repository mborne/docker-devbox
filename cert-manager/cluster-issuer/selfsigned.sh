#!/bin/bash

echo "------------------------------------------------------------"
echo "-- cert-manager/cluster-issuer/selfsigned.sh"
echo "------------------------------------------------------------"

# Create mkcert ClusterIssuer
# Adapted from https://cert-manager.io/docs/configuration/selfsigned/#bootstrapping-ca-issuers
#
# - clusterissuer/selfsigned-bootstrap allows to generate certificate/devbox-selfsigned-ca
# - clusterissuer/selfsigned relies on certificate/devbox-selfsigned-ca
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: selfsigned-bootstrap
spec:
  selfSigned: {}
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: devbox-selfsigned-ca
  namespace: cert-manager
spec:
  isCA: true
  commonName: devbox-selfsigned-ca
  secretName: devbox-selfsigned-ca
  privateKey:
    algorithm: ECDSA
    size: 256
  issuerRef:
    name: selfsigned-bootstrap
    kind: ClusterIssuer
    group: cert-manager.io
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: selfsigned
spec:
  ca:
    secretName: devbox-selfsigned-ca
EOF



