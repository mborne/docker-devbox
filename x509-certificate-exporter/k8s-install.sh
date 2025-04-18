#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

helm repo add enix https://charts.enix.io
helm repo update

helm upgrade --install certificate-exporter enix/x509-certificate-exporter \
    --namespace x509-certificate-exporter \
    --create-namespace \
    -f "${SCRIPT_DIR}/helm/values.yaml"

