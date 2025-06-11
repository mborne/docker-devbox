#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "---------------------------------------------"
echo "-- fluent"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Create namespace fluent if not exists
kubectl create namespace fluent --dry-run=client -o yaml | kubectl apply -f -

# Deploy fluent-bit with helm
helm -n fluent upgrade --install fluent-bit oci://registry-1.docker.io/bitnamicharts/fluent-bit \
  -f ${SCRIPT_DIR}/helm/fluent-bit/values.yaml

# Allow fluent-bit sa to retreive infos about containers
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: fluent-bit-read
subjects:
- kind: ServiceAccount
  name: fluent-bit
  namespace: fluent
roleRef:
  kind: ClusterRole
  name: view
  apiGroup: rbac.authorization.k8s.io
EOF






