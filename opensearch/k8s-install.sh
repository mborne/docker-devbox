#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-selfsigned}

echo "---------------------------------------------"
echo "-- opensearch"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# 
# https://docs.opensearch.org/docs/latest/install-and-configure/install-opensearch/helm/
#
helm repo add opensearch https://opensearch-project.github.io/helm-charts/
helm repo update

# Create namespace opensearch if not exists
kubectl create namespace opensearch --dry-run=client -o yaml | kubectl apply -f -

# Create opensearch cluster
# CHART_VERSION=2.34.0 -> APP_VERSION=2.19.2
helm -n opensearch upgrade --install opensearch-cluster opensearch/opensearch --version=2.34.0 \
  -f "${SCRIPT_DIR}/helm/opensearch/values.yaml"

# Deploy opensearch-dashboard
# CHART_VERSION=2.30.0 -> APP_VERSION=2.19.2
helm -n opensearch upgrade --install opensearch-dashboards opensearch/opensearch-dashboards --version=2.30.0 \
  -f "${SCRIPT_DIR}/helm/opensearch-dashboards/values.yaml"

# Create Ingress with dynamic hostname for opensearch
cat <<EOF | kubectl -n opensearch apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: opensearch
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: os.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: opensearch-cluster-master
            port:
              number: 9200
  tls:
  - hosts:
    - os.$DEVBOX_HOSTNAME
    secretName: opensearch-cert
EOF


# Create Ingress with dynamic hostname for opensearch
cat <<EOF | kubectl -n opensearch apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: opensearch-dashboard
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: os-dashboard.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: opensearch-dashboards
            port:
              number: 5601
  tls:
  - hosts:
    - os-dashboard.$DEVBOX_HOSTNAME
    secretName: opensearch-dashboard-cert
EOF
