#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-mkcert}

GRAFANA_ADMIN_PASSWORD=${GRAFANA_ADMIN_PASSWORD:-ChangeIt}

# Add helm repository
helm repo add grafana https://grafana.github.io/helm-charts

# Update helm repositories
helm repo update

# Create namespace grafana if not exists
kubectl create namespace grafana --dry-run=client -o yaml | kubectl apply -f -


HELM_OPTS=""
if [ ! -z "$HTTP_PROXY" ];
then
  HELM_OPTS="${HELM_OPTS} --set downloadDashboards.env.HTTP_PROXY=$HTTP_PROXY"
fi
if [ ! -z "$HTTPS_PROXY" ];
then
  HELM_OPTS="${HELM_OPTS} --set downloadDashboards.env.HTTPS_PROXY=$HTTPS_PROXY"
fi

# Install grafana
helm -n grafana upgrade --install grafana grafana/grafana \
    -f ${SCRIPT_DIR}/helm/values.yaml $HELM_OPTS \
    --set adminPassword=$GRAFANA_ADMIN_PASSWORD




# Create Ingress with dynamic hostname
cat <<EOF | kubectl -n grafana apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: grafana
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: grafana.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: ImplementationSpecific
        path: "/"
        backend:
          service:
            name: grafana
            port:
              number: 80
  tls:
  - hosts:
    - grafana.$DEVBOX_HOSTNAME
    secretName: grafana-cert
EOF


# Display resources
kubectl -n grafana get pods,svc,ingress
