#!/bin/bash

# Deploy cert-manager with helm
helm -n cert-manager uninstall cert-manager

# # Wait for pods to be ready
# kubectl wait --namespace cert-manager \
#     --for=condition=ready pod \
#     --selector=app=metallb \
#     --timeout=90s

