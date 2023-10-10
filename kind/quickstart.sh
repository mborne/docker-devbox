#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DEVBOX_DIR=$(dirname $SCRIPT_DIR)

echo "---------------------------------------------"
echo "-- kind/quickstart.sh"
echo "---------------------------------------------"

USE_CANAL=${USE_CANAL:-0}
USE_CALICO=${USE_CALICO:-0}
if [ "$USE_CANAL" != "0" ] || [ "$USE_CALICO" != "0" ];
then
    export DISABLE_DEFAULT_CNI=true
fi
bash $DEVBOX_DIR/kind/config/generate.sh | kind create cluster --config -

#---------------------------------------------------------------------------
# Install canal
# see https://docs.tigera.io/calico/latest/getting-started/kubernetes/flannel/install-for-flannel#installing-with-the-kubernetes-api-datastore-recommended
#---------------------------------------------------------------------------
if [ "$USE_CANAL" != "0" ];
then
    kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/canal.yaml
    # wait for canal pods
    kubectl wait --namespace kube-system \
        --for=condition=ready pod \
        --selector=k8s-app=canal \
        --timeout=90s

fi

#---------------------------------------------------------------------------
# Install calico
# see https://docs.tigera.io/calico/latest/getting-started/kubernetes/quickstart#install-calico
#---------------------------------------------------------------------------
if [ "$USE_CALICO" != "0" ];
then
    kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
    # wait for tigera-operator
    kubectl wait --namespace tigera-operator \
        --for=condition=ready pod \
        --selector=k8s-app=tigera-operator \
        --timeout=90s

    # install calico with consistent pod subnet
    kubectl apply -f ${SCRIPT_DIR}/calico/custom-resources.yaml
fi


#----------------------------------------
# Install metric-server
#----------------------------------------

kubectl apply -k ${SCRIPT_DIR}/metric-server

#----------------------------------------
# Install cert-manager
#----------------------------------------

bash $DEVBOX_DIR/cert-manager/k8s-install.sh
# create mkcert issuer if available
if which mkcert >/dev/null; then
    bash $DEVBOX_DIR/cert-manager/cluster-issuer/mkcert.sh
fi

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

