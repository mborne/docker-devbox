#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DEVBOX_DIR=$(dirname "$SCRIPT_DIR")

echo "---------------------------------------------"
echo "-- kind/quickstart.sh"
echo "---------------------------------------------"

if ! command -v kind &> /dev/null; then
  echo "kind is required."
  exit 1
fi

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

#----------------------------------------------------------------------------------
# Generate kind config according to env vars
#----------------------------------------------------------------------------------
bash "$DEVBOX_DIR/kind/config/generate.sh" > /tmp/kind-config.yml
cat /tmp/kind-config.yml
kind create cluster --config /tmp/kind-config.yml || {
    echo "fail to create kind cluster"
    exit 1 
}

#----------------------------------------------------------------------------------
# Install CNI
#----------------------------------------------------------------------------------
KIND_CNI=${KIND_CNI:-default}
if [ "$KIND_CNI" != "default" ];
then
    bash "${SCRIPT_DIR}/cni/${KIND_CNI}/install.sh"
fi

#----------------------------------------------------------------------------------
# Wait for nodes to be ready
#----------------------------------------------------------------------------------
kubectl wait --for=condition=Ready nodes --all --timeout=600s

#----------------------------------------------------------------------------------
# Install metric-server
#----------------------------------------------------------------------------------
kubectl apply -k "${SCRIPT_DIR}/metric-server"

#----------------------------------------------------------------------------------
# Install cert-manager
#----------------------------------------------------------------------------------
bash "${DEVBOX_DIR}/cert-manager/k8s-install.sh"

#----------------------------------------------------------------------------------
# Install ingress controller
#----------------------------------------------------------------------------------
export DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
if [ "$DEVBOX_INGRESS" == "traefik" ];
then
    TRAEFIK_MODE=kind bash "${DEVBOX_DIR}/traefik/k8s-install.sh"
else
    echo "skip traefik installation (DEVBOX_INGRESS=${DEVBOX_INGRESS})"
fi

#----------------------------------------------------------------------------------
# Install dashboard
#----------------------------------------------------------------------------------
bash "${DEVBOX_DIR}/kubernetes-dashboard/k8s-install.sh"

#----------------------------------------------------------------------------------
# Install whoami
#----------------------------------------------------------------------------------
bash "${DEVBOX_DIR}/whoami/k8s-install.sh"
