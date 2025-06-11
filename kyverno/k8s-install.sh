#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-selfsigned}

echo "---------------------------------------------"
echo "-- kyverno/k8s-install.sh"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi


#-------------------------------------------------------------------------
# kyverno and kyverno-policies
#-------------------------------------------------------------------------

# Add helm repository
helm repo add kyverno https://kyverno.github.io/kyverno/

# Update helm repositories
helm repo update

# Create namespace kyverno if not exists
kubectl create namespace kyverno --dry-run=client -o yaml | kubectl apply -f -

# Install kyverno
helm -n kyverno upgrade --install kyverno kyverno/kyverno \
    -f "${SCRIPT_DIR}/helm/kyverno/values.yaml"

# Install kyverno-policies (after due to CRDs)
helm -n kyverno upgrade --install kyverno-policies kyverno/kyverno-policies \
    -f "${SCRIPT_DIR}/helm/kyverno-policies/values.yaml"

#-------------------------------------------------------------------------
# policy-reporter for kyverno
#-------------------------------------------------------------------------

# add helm repository
helm repo add policy-reporter https://kyverno.github.io/policy-reporter

# update helm repositories
helm repo update

# deploy in namespace kyverno-ui
helm -n kyverno upgrade --install policy-reporter policy-reporter/policy-reporter \
    -f "${SCRIPT_DIR}/helm/policy-reporter/values.yaml"

# Create Ingress with dynamic hostname for policy-reporter-ui
cat <<EOF | kubectl -n kyverno apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: policy-reporter-ui
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: kyverno.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: policy-reporter-ui
            port:
              number: 8080
  tls:
  - hosts:
    - kyverno.$DEVBOX_HOSTNAME
    secretName: policy-reporter-ui-cert
EOF
