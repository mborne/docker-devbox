#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DEVBOX_DIR=$(dirname $SCRIPT_DIR)

echo "--------------------------------------------------------------------"
echo "-- kind/quickstart.sh - create cluster..."
echo "--------------------------------------------------------------------"

bash $DEVBOX_DIR/kind/config/generate.sh | kind create cluster --config -

echo "--------------------------------------------------------------------"
echo "-- kind/quickstart.sh - install cert-manager..."
echo "--------------------------------------------------------------------"

bash $DEVBOX_DIR/cert-manager/k8s-install.sh
# create mkcert issuer if available
if which mkcert >/dev/null; then
    bash $DEVBOX_DIR/cert-manager/cluster-issuer/mkcert.sh
fi

echo "--------------------------------------------------------------------"
echo "-- kind/quickstart.sh - install ingress controller..."
echo "--------------------------------------------------------------------"

DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
if [ "$DEVBOX_INGRESS" != "traefik" ];
then
    NGINX_MODE=kind bash $DEVBOX_DIR/nginx-ingress-controller/k8s-install.sh
else
    TRAEFIK_MODE=kind bash $DEVBOX_DIR/traefik/k8s-install.sh
fi

echo "--------------------------------------------------------------------"
echo "-- kind/quickstart.sh - install sample app whoami..."
echo "--------------------------------------------------------------------"

DEVBOX_INGRESS=${DEVBOX_INGRESS} TRAEFIK_MODE=kind bash $DEVBOX_DIR/whoami/k8s-install.sh

