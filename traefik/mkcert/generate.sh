#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME="${DEVBOX_HOSTNAME:-dev.localhost}"

if which mkcert >/dev/null; then
    echo "Found mkcert ..."
else
    echo "mkcert not found, see :"
    echo "- https://github.com/FiloSottile/mkcert#mkcert and follow instruction"
    echo "- or https://github.com/FiloSottile/mkcert/releases/latest to get binary file"
    exit 1
fi


echo "Generate certificate for DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME}..."

mkcert \
    -key-file ${SCRIPT_DIR}/default-key.pem \
    -cert-file ${SCRIPT_DIR}/default.pem \
    "*.${DEVBOX_HOSTNAME}" ${DEVBOX_HOSTNAME} localhost

echo "Copy default.pem to traefik:/certs/default-key.pem ..."
docker cp ${SCRIPT_DIR}/default.pem traefik:/certs/default.pem
echo "Copy default-key.pem to traefik:/certs/default-key.pem ..."
docker cp ${SCRIPT_DIR}/default-key.pem traefik:/certs/default-key.pem
echo "Restart traefik ..."
docker restart traefik
