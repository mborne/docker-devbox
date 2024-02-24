#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DEVBOX_DIR=$(dirname $SCRIPT_DIR)

echo "---------------------------------------------"
echo "-- kind/quickstart.sh"
echo "---------------------------------------------"

bash $DEVBOX_DIR/kind/config/generate.sh > /tmp/kind-config.yml
cat /tmp/kind-config.yml
kind create cluster --config /tmp/kind-config.yml

#----------------------------------------
# Install CNI
#----------------------------------------
KIND_CNI=${KIND_CNI:-default}
if [ "$KIND_CNI" != "default" ];
then
    bash ${SCRIPT_DIR}/cni/${KIND_CNI}/install.sh
fi

#----------------------------------------
# Install metric-server
#----------------------------------------
kubectl apply -k ${SCRIPT_DIR}/metric-server

#----------------------------------------
# Install cert-manager
#----------------------------------------
bash $DEVBOX_DIR/cert-manager/k8s-install.sh

#----------------------------------------
# Install ingress controller
#----------------------------------------

export DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
if [ "$DEVBOX_INGRESS" != "traefik" ];
then
    NGINX_MODE=kind bash $DEVBOX_DIR/nginx-ingress-controller/k8s-install.sh
else
    TRAEFIK_MODE=kind bash $DEVBOX_DIR/traefik/k8s-install.sh
fi


#----------------------------------------
# Install dashboard
#----------------------------------------

bash $DEVBOX_DIR/kubernetes-dashboard/k8s-install.sh


#----------------------------------------
# Install whoami
#----------------------------------------

bash $DEVBOX_DIR/whoami/k8s-install.sh

