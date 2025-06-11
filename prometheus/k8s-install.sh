#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-selfsigned}

echo "---------------------------------------------"
echo "-- prometheus"
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
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# Update helm repositories
helm repo update

# Create namespace prometheus if not exists
kubectl create namespace prometheus --dry-run=client -o yaml | kubectl apply -f -

# Deploy prometheus-operator without grafana
helm upgrade -n prometheus --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  -f ${SCRIPT_DIR}/helm/prometheus-stack/values.yaml

# Deploy prometheus-blackbox-exporter with sample ServiceMonitors
helm upgrade -n prometheus --install prometheus-blackbox-exporter prometheus-community/prometheus-blackbox-exporter \
  -f ${SCRIPT_DIR}/helm/blackbox-exporter/values.yaml


# Create Ingress with dynamic hostname for prometheus-operated
cat <<EOF | kubectl -n prometheus apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: prometheus
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: prometheus.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: ImplementationSpecific
        path: "/"
        backend:
          service:
            name: prometheus-operated
            port:
              number: 9090
  tls:
  - hosts:
    - prometheus.$DEVBOX_HOSTNAME
    secretName: prometheus-cert
EOF


# Create Ingress with dynamic hostname for prometheus
cat <<EOF | kubectl -n prometheus apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: blackbox-exporter
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: blackbox-exporter.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: ImplementationSpecific
        path: "/"
        backend:
          service:
            name: prometheus-blackbox-exporter
            port:
              number: 9115
  tls:
  - hosts:
    - blackbox-exporter.$DEVBOX_HOSTNAME
    secretName: blackbox-exporter-cert
EOF
