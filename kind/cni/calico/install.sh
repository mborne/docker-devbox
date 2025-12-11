#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "---------------------------------------------"
echo "-- kind/cni/calico/install.sh"
echo "---------------------------------------------"

#---------------------------------------------------------------------------
# Install calico
# see https://docs.tigera.io/calico/latest/getting-started/kubernetes/quickstart#install-calico
#---------------------------------------------------------------------------
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.31.2/manifests/operator-crds.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.31.2/manifests/tigera-operator.yaml
# wait for tigera-operator
kubectl wait --namespace tigera-operator \
    --for=condition=ready pod \
    --selector=k8s-app=tigera-operator \
    --timeout=90s

# sleep 5

# # Wait for Tigera CRDs to be established
# kubectl wait --for=condition=Established --timeout=60s crd/apiservers.operator.tigera.io
# kubectl wait --for=condition=Established --timeout=60s crd/gatewayapis.operator.tigera.io
# kubectl wait --for=condition=Established --timeout=60s crd/goldmanes.operator.tigera.io
# kubectl wait --for=condition=Established --timeout=60s crd/imagesets.operator.tigera.io
# kubectl wait --for=condition=Established --timeout=60s crd/installations.operator.tigera.io
# kubectl wait --for=condition=Established --timeout=60s crd/managementclusterconnections.operator.tigera.io
# kubectl wait --for=condition=Established --timeout=60s crd/tigerastatuses.operator.tigera.io
# kubectl wait --for=condition=Established --timeout=60s crd/whiskers.operator.tigera.io


# install calico with consistent pod subnet
#kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.31.2/manifests/custom-resources.yaml
kubectl apply -f "${SCRIPT_DIR}/custom-resources.yaml"

# wait for calico pods
kubectl wait --namespace calico-system \
    --for=condition=ready pod \
    --selector=k8s-app=calico-kube-controllers \
    --timeout=90s

kubectl wait --namespace calico-system \
    --for=condition=ready pod \
    --selector=k8s-app=calico-node \
    --timeout=90s



