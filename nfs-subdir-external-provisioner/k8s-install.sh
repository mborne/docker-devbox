#!/bin/bash

NFS_SERVER_IP=${NFS_SERVER_IP:-nfs-server.nfs-system.svc.cluster.local}
NFS_PATH=${NFS_PATH:-/exports}
echo "Install nfs-subdir-external-provisioner with :"
echo "- NFS_SERVER_IP=${NFS_SERVER_IP}"
echo "- NFS_PATH=${NFS_PATH}"

# Add helm repository
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

# Update helm repositories
helm repo update

# Create namespace nfs if not exists
kubectl create namespace nfs --dry-run=client -o yaml | kubectl apply -f -

# Deploy nfs-subdir-external-provisioner with helm
# see https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner/blob/master/charts/nfs-subdir-external-provisioner/README.md#readme
helm -n nfs upgrade --install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=${NFS_SERVER_IP} \
    --set nfs.path=${NFS_PATH} \
    --set storageClass.accessModes=ReadWriteMany \
    --set storageClass.name=nfs-client
