#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Add helm repository
helm repo add hashicorp https://helm.releases.hashicorp.com

# Update helm repositories
helm repo update

# Create namespace vault if not exists
kubectl create namespace vault --dry-run=client -o yaml | kubectl apply -f -

# Install vault
helm -n vault install vault hashicorp/vault \
    --set='server.ha.enabled=true' \
    --set='server.ha.raft.enabled=true' \
    --set='server.affinity=~'


