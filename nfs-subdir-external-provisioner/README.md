# nfs-subdir-external-provisioner

Deploy [kubernetes-sigs/nfs-subdir-external-provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner#readme) to provide a RWX storage class based on an existing NFS server.

## Requirements

* An available NFS server

> See [nfs-server](../nfs-server/README.md) for test purpose or [www.digitalocean.com - How To Set Up an NFS Mount on Ubuntu 22.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-22-04) for classic installation with `nfs-kernel-server`

## Parameters

| Name            | Description          | Default                                       |
| --------------- | -------------------- | --------------------------------------------- |
| `NFS_SERVER_IP` | IP of the NFS server | `nfs-server.nfs-system.svc.cluster.local` (1) |
| `NFS_PATH`      | Path to the export   | `/` (2)                                       |

> (1) See [Troubleshooting](#troubleshooting)
> (2) Use export with `fsid=0` in `/etc/exports` on NFS server

## Usage with Kubernetes

* Deploy [nfs-server](../nfs-server/README.md) or adapt params to use an existing NFS server :

```bash
# Ex with nfs-server on vagrantbox-1
# (https://github.com/mborne/k3s-deploy)
export NFS_SERVER_IP=192.168.50.201
export NFS_PATH=/
```

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
bash k8s-install.sh

# check nfs-subdir-external-provisioner deployment status (READY 1/1)
kubectl -n nfs-system get deployment

# ensure that storageclass is defined
kubectl get storageclass
```

* See [nfs-demo](../nfs-demo/README.md) for an example using the "nfs" StorageClass

## Troubleshooting

### DNS resolution from node

With `NFS_SERVER_IP=nfs-server.nfs-system.svc.cluster.local`, you may face **name resolution issues especially with kind** :

> Unable to attach or mount volumes: unmounted volumes=[nfs-subdir-external-provisioner-root], unattached volumes=[kube-api-access-p2vmw nfs-subdir-external-provisioner-root]: timed out waiting for the condition

Use the following workaround if nodes are not configured to invoke embedded DNS to resolve `.cluster.local` IP's :

```bash
export NFS_SERVER_IP=$(kubectl -n nfs-system get svc/nfs-server -o jsonpath='{.spec.clusterIP}')
export NFS_PATH=/
bash nfs-subdir-external-provisioner/k8s-install.sh
```

### IP stability

Note that `NFS_SERVER_IP` will be present in PersistentVolume definitions and that the corresponding IP is resolved at mount time if a domain name is provided.

Using something like `NFS_SERVER_IP=dns-server.priv.example.com` and ensuring stability NFS server IP is probably a good idea to avoid problems.


## Resources

* [github.com/kubernetes-sigs - Kubernetes NFS Subdir External Provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner#kubernetes-nfs-subdir-external-provisioner)
* [docs.ovh.com - Configuring multi-attach persistent volumes with OVHcloud NAS-HA](https://docs.ovh.com/gb/en/kubernetes/configuring-multi-attach-persistent-volumes-with-ovhcloud-nas-ha/)
