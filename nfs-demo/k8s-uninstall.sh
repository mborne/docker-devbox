#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Uninstall nfs-demo
kubectl -n nfs-demo delete -k ${SCRIPT_DIR}/manifest

# Remove Ingress
kubectl -n nfs-demo delete ingress nfs-demo

# Remove namespace
kubectl delete namespace nfs-demo

