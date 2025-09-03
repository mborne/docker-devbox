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

# helm search repo kyverno/kyverno -l 
# NAME                            CHART VERSION   APP VERSION
# kyverno/kyverno                 3.5.1           v1.15.1
# kyverno/kyverno                 3.5.0           v1.15.0
# kyverno/kyverno                 3.4.4           v1.14.4
# kyverno/kyverno                 3.4.3           v1.14.3
#
# see https://kyverno.io/docs/installation/#compatibility-matrix
KYVERNO_VERSION=3.4.4

# Install kyverno
helm -n kyverno upgrade --install kyverno \
    kyverno/kyverno --version=$KYVERNO_VERSION \
    -f "${SCRIPT_DIR}/helm/kyverno/values.yaml"

# Install kyverno-policies (after due to CRDs)
helm -n kyverno upgrade --install kyverno-policies \
    kyverno/kyverno-policies --version=$KYVERNO_VERSION \
    -f "${SCRIPT_DIR}/helm/kyverno-policies/values.yaml"

#-------------------------------------------------------------------------
# policy-reporter for kyverno
#-------------------------------------------------------------------------

# add helm repository
helm repo add policy-reporter https://kyverno.github.io/policy-reporter

# update helm repositories
helm repo update

# helm search repo policy-reporter
# NAME                            CHART VERSION   APP VERSION
# policy-reporter/policy-reporter 3.4.2           3.4.2
POLICY_REPORTER_VERSION=3.4.2

# deploy in namespace kyverno-ui
helm -n kyverno upgrade --install policy-reporter \
  policy-reporter/policy-reporter --version=$POLICY_REPORTER_VERSION \
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
