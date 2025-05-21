#!/bin/bash

# Remove opensearch-cluster
helm -n opensearch uninstall opensearch-cluster

# Remove opensearch-dashboard
helm -n opensearch uninstall opensearch-dashboards

# Remove ingresses
kubectl -n opensearch delete ingress opensearch
kubectl -n opensearch delete ingress opensearch-dashboard

