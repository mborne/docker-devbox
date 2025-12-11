#!/bin/bash

echo "---------------------------------------------"
echo "-- kind/cni/canal/install.sh"
echo "---------------------------------------------"

#---------------------------------------------------------------------------
# Install canal
# see https://docs.tigera.io/calico/latest/getting-started/kubernetes/flannel/install-for-flannel#installing-with-the-kubernetes-api-datastore-recommended
#---------------------------------------------------------------------------
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.31.2/manifests/canal.yaml

# wait for canal pods
kubectl wait --namespace kube-system \
    --for=condition=ready pod \
    --selector=k8s-app=canal \
    --timeout=90s
