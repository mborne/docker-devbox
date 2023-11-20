#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

kubectl -n vault exec -ti vault-0 -- /bin/sh -c "vault operator init -key-shares=1 -key-threshold=1 -format=json" > cluster-keys.json

VAULT_UNSEAL_KEY=$(cat cluster-keys.json | jq -r ".unseal_keys_b64[]")
CLUSTER_ROOT_TOKEN=$(cat cluster-keys.json | jq -r ".root_token")

# Unseal vault-0
kubectl -n vault exec vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY
kubectl -n vault exec vault-0 -- vault login $CLUSTER_ROOT_TOKEN

sleep 10

# Unseal vault-1 and join vault-0
kubectl -n vault exec vault-1 -- vault operator raft join http://vault-0.vault-internal:8200
kubectl -n vault exec vault-1 -- vault operator unseal $VAULT_UNSEAL_KEY

sleep 5

# Unseal vault-2 and join vault-0
kubectl -n vault exec vault-2 -- vault operator raft join http://vault-0.vault-internal:8200
kubectl -n vault exec vault-2 -- vault operator unseal $VAULT_UNSEAL_KEY

kubectl -n vault exec vault-0 -- vault operator raft list-peers

