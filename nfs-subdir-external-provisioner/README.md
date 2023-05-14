# nfs-subdir-external-provisioner

Deploy [kubernetes-sigs/nfs-subdir-external-provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner#readme) to provide a RWX storage class based on an existing NFS server.

## Parameters

| Name          | Description          | Default                                 |
|---------------|----------------------|-----------------------------------------|
| NFS_SERVER_IP | IP of the NFS server | nfs-server.nfs-system.svc.cluster.local |
| NFS_PATH      | Path to the export   | `/exports`                              |

## Usage with Kubernetes

* Deploy [nfs-server](../nfs-server/README.md) or adapt params to use an existing NFS server :

```bash
export NFS_SERVER_IP=nfs-server.nfs-system.svc.cluster.local
export NFS_PATH=/exports
```

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
bash k8s-install.sh
kubectl get storageclass
```

## Resources

* [github.com/kubernetes-sigs - Kubernetes NFS Subdir External Provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner#kubernetes-nfs-subdir-external-provisioner)
* [docs.ovh.com - Configuring multi-attach persistent volumes with OVHcloud NAS-HA](https://docs.ovh.com/gb/en/kubernetes/configuring-multi-attach-persistent-volumes-with-ovhcloud-nas-ha/)

