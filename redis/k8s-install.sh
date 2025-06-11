#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

REDIS_PASSWORD=${REDIS_PASSWORD:-ChangeIt}

echo "---------------------------------------------"
echo "-- redis"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Deploy redis with helm
helm -n redis upgrade --install --create-namespace redis oci://registry-1.docker.io/bitnamicharts/redis \
  -f ${SCRIPT_DIR}/helm/values.yaml \
  --set auth.password=$REDIS_PASSWORD \

# Display resources
kubectl -n redis get pods,svc,ingress
