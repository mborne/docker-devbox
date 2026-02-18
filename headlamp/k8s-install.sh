#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-selfsigned}


echo "---------------------------------------------"
echo "-- headlamp"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# add headlamp repository
helm repo add headlamp https://kubernetes-sigs.github.io/headlamp/
helm repo update

# Create namespace headlamp if not exists
kubectl create namespace headlamp --dry-run=client -o yaml | kubectl apply -f -

# Create headlamp-admin with cluster-admin role to simplify token retrieval
kubectl -n headlamp create serviceaccount admin-user --dry-run=client -o yaml | kubectl apply -f -
kubectl create clusterrolebinding admin-user-crb --clusterrole=cluster-admin \
    --serviceaccount=headlamp:admin-user \
    --dry-run=client -o yaml | kubectl apply -f -


# install headlamp in a dedicated namespace
bash ${SCRIPT_DIR}/helm/values.sh | helm -n headlamp upgrade --install headlamp headlamp/headlamp \
  --version=0.40.0 -f -


# Create Ingress with dynamic hostname
cat <<EOF | kubectl -n headlamp apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: headlamp
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: dashboard.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: ImplementationSpecific
        path: "/"
        backend:
          service:
            name: headlamp
            port:
              number: 80
  tls:
  - hosts:
    - headlamp.$DEVBOX_HOSTNAME
    secretName: headlamp-cert
EOF
