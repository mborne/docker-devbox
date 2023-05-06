#!/bin/bash

# Add helm repository
helm repo add stable https://charts.helm.sh/stable

# Update helm repositories
helm repo update

# Create namespace nfs-system if not exists
kubectl create namespace nfs-system --dry-run=client -o yaml | kubectl apply -f -

# Deploy nfs-system with helm
# https://artifacthub.io/packages/helm/kvaps/nfs-server-provisioner#configuration
helm -n nfs-system upgrade --install nfs-server stable/nfs-server-provisioner \
  --set persistence.enabled=true,persistence.size=200Gi \
  --set storageClass.name=nfs
