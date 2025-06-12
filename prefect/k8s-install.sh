#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}

echo "---------------------------------------------"
echo "-- prefect"
echo "---------------------------------------------"
if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi
if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Create namespace prefect if not exists
kubectl create namespace prefect --dry-run=client -o yaml | kubectl apply -f -

helm repo add prefect https://prefecthq.github.io/prefect-helm
helm repo update

# helm search repo prefect/prefect-server
# APP_VERSION=3.4.6
CHART_VERSION_PREFECT_SERVER=${CHART_VERSION_PREFECT_SERVER:-2025.6.11195951}

# helm search repo prefect/prefect-worker
# APP_VERSION=3.4.6
CHART_VERSION_PREFECT_WORKER=${CHART_VERSION_PREFECT_WORKER:-2025.6.11195951}


# Deploy prefect with helm
helm -n prefect upgrade --install prefect-server prefect/prefect-server \
    --version ${CHART_VERSION_PREFECT_SERVER} \
    --set server.uiConfig.prefectUiApiUrl="http://prefect.${DEVBOX_HOSTNAME}/api/"

# Create Ingress with dynamic hostname for prefect-server
cat <<EOF | kubectl -n prefect apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: prefect
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: prefect.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: ImplementationSpecific
        path: "/"
        backend:
          service:
            name: prefect-server
            port:
              number: 4200
  tls:
  - hosts:
    - prometheus.$DEVBOX_HOSTNAME
    secretName: prefect-cert
EOF

# Wait for prefect-server to be ready
kubectl -n prefect wait --for=condition=available --timeout=600s deployment/prefect-server

# Deploy prefect-worker
helm --namespace=prefect upgrade --install prefect-worker prefect/prefect-worker \
    --version ${CHART_VERSION_PREFECT_WORKER} \
    -f ${SCRIPT_DIR}/helm/prefect-worker/values.yaml \
    --set-file worker.config.baseJobTemplate.configuration=${SCRIPT_DIR}/helm/prefect-worker/base-job-template.json

