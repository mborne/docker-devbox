#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-selfsigned}

MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD:-ChangeIt}

echo "---------------------------------------------"
echo "-- minio"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Add helm repository
helm repo add minio-operator https://operator.min.io

# Update helm repositories
helm repo update

# Install minio-operator
helm upgrade --install \
  --namespace minio-operator \
  --create-namespace \
  operator minio-operator/operator

# Create namespace minio if not exists
kubectl create namespace minio --dry-run=client -o yaml | kubectl apply -f -

helm -n minio upgrade --install minio minio-operator/tenant -f ${SCRIPT_DIR}/helm/minio/values.yaml \
  --set tenant.configSecret.secretKey="$MINIO_ROOT_PASSWORD" \
  --set tenant.env[0].value="https://minio.$DEVBOX_HOSTNAME"

# Create Ingress with dynamic hostname
cat <<EOF | kubectl -n minio apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: minio-console
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: minio.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: minio-console
            port:
              number: 9090
  tls:
  - hosts:
    - minio.$DEVBOX_HOSTNAME
    secretName: minio-console-cert
EOF


cat <<EOF | kubectl -n minio apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: minio-s3
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: minio-s3.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: minio
            port:
              number: 80
  tls:
  - hosts:
    - minio-s3.$DEVBOX_HOSTNAME
    secretName: minio-s3-cert
EOF
