#!/bin/bash

# Create opensearch cluster
helm -n opensearch uninstall opensearch-cluster

# Remove ingresses
kubectl -n opensearch delete ingress opensearch
kubectl -n opensearch delete ingress opensearch-dashboard

kubectl -n opensearch delete $(kubectl -n opensearch get pvc -o name)

