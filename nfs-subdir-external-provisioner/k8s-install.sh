#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

NFS_SERVER_IP=${NFS_SERVER_IP:-nfs-server.nfs-system.svc.cluster.local}
NFS_PATH=${NFS_PATH:-/exports}

echo "---------------------------------------------"
echo "-- nfs-subdir-external-provisioner"
echo "---------------------------------------------"

if ! command -v kubectl &> /dev/null; then
  echo "kubectl is required."
  exit 1
fi

if ! command -v helm &> /dev/null; then
  echo "helm is required."
  exit 1
fi

echo "Install nfs-subdir-external-provisioner with :"
echo "- NFS_SERVER_IP=${NFS_SERVER_IP}"
echo "- NFS_PATH=${NFS_PATH}"

# Add helm repository
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

# Update helm repositories
helm repo update

# Create namespace nfs if not exists
kubectl create namespace nfs-system --dry-run=client -o yaml | kubectl apply -f -

# Deploy nfs-subdir-external-provisioner with helm
# see https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner/blob/master/charts/nfs-subdir-external-provisioner/README.md#readme
helm -n nfs-system upgrade --install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=${NFS_SERVER_IP} \
    --set nfs.path=${NFS_PATH} \
    --set storageClass.accessModes=ReadWriteMany \
    --set storageClass.name=nfs


