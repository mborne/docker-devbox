#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-mkcert}

# Add helm repository
helm repo add opensearch https://opensearch-project.github.io/helm-charts/

# Update helm repositories
helm repo update

# Create namespace opensearch if not exists
kubectl create namespace opensearch --dry-run=client -o yaml | kubectl apply -f -

# Create opensearch cluster
helm -n opensearch upgrade --install opensearch-cluster opensearch/opensearch

# Install opensearch dashboard
helm -n opensearch upgrade --install opensearch-dashboards opensearch/opensearch-dashboards


# Create Ingress with dynamic hostname
cat <<EOF | kubectl -n opensearch apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: opensearch-dashboards
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: opensearch-dashboards.$DEVBOX_HOSTNAME
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
    - opensearch-dashboards.$DEVBOX_HOSTNAME
    secretName: opensearch-dashboards-cert
EOF
