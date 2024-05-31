#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-mkcert}

# Create namespace opensearch if not exists
kubectl create namespace opensearch --dry-run=client -o yaml | kubectl apply -f -

# Create opensearch cluster
helm -n opensearch upgrade --install opensearch-cluster oci://registry-1.docker.io/bitnamicharts/opensearch \
  -f "${SCRIPT_DIR}/helm/bitnami-opensearch/values.yaml"


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
            name: opensearch-cluster
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
            name: opensearch-cluster-dashboards
            port:
              number: 5601
  tls:
  - hosts:
    - os-dashboard.$DEVBOX_HOSTNAME
    secretName: opensearch-dashboard-cert
EOF
