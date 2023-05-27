#!/bin/bash

KIND_SUBNET=$(docker network inspect kind | jq -r '.[].IPAM.Config[0].Subnet')
echo "KIND_SUBNET=${KIND_SUBNET}"

# remove .0/24
BASE_SUBNET=$(echo "$KIND_SUBNET" | sed "s/\\.0\\/24//")

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml

# Wait for pods to be ready
kubectl wait --namespace metallb-system \
    --for=condition=ready pod \
    --selector=app=metallb \
    --timeout=90s

cat <<EOF | kubectl -n metallb-system apply -f -
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: example
  namespace: metallb-system
spec:
  addresses:
  - ${BASE_SUBNET}.200-${BASE_SUBNET}.250
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: empty
  namespace: metallb-system
EOF