#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

VALKEY_PASSWORD=${VALKEY_PASSWORD:-ChangeIt}

echo "---------------------------------------------"
echo "-- valkey"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Add helm repo
helm repo add valkey https://valkey.io/valkey-helm/
helm repo update

# Deploy valkey with helm
helm -n valkey upgrade --install --create-namespace valkey valkey/valkey \
  -f ${SCRIPT_DIR}/helm/values.yaml \
  --set auth.aclUsers.default.password=$VALKEY_PASSWORD \

# Display resources
kubectl -n valkey get pods,svc,ingress
