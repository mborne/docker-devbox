#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "---------------------------------------------"
echo "-- external-dns"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

# Create namespace external-dns if not exists
kubectl create namespace external-dns --dry-run=client -o yaml | kubectl apply -f -

# Create secret for CloudFlare
if [ -z "$CLOUDFLARE_API_TOKEN" ];
then
    echo "CLOUDFLARE_API_TOKEN is required"
    exit 1
fi
kubectl -n external-dns create secret generic cloudflare-api-key --from-literal=apiKey=$CLOUDFLARE_API_TOKEN

helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/
helm repo update
helm -n external-dns upgrade --install external-dns external-dns/external-dns \
    --version "1.17.0" \
    --values "${SCRIPT_DIR}/helm/cloudflare/values.yaml"

