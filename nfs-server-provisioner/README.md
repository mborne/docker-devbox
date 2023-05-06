# NFS

Deploy a NFS server with [stable/nfs-server-provisioner](https://github.com/helm/charts/tree/master/stable/nfs-server-provisioner#readme) helm chart to test simple solution to bring RWX in Kubernetes.

## Usage with Kubernetes

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
bash k8s-install.sh
kubectl get storageclass
```

* Ensure pod is running : `kubectl -n nfs-system get pods,svc`
* Ensure "nfs" StorageClass is available : `kubectl get storageclass`

## Alternatives

### External DNS

See [kubernetes-sigs/nfs-subdir-external-provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner#readme) :

* [github.com/kubernetes-sigs - Kubernetes NFS Subdir External Provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner#kubernetes-nfs-subdir-external-provisioner)
* [docs.ovh.com - Configuring multi-attach persistent volumes with OVHcloud NAS-HA](https://docs.ovh.com/gb/en/kubernetes/configuring-multi-attach-persistent-volumes-with-ovhcloud-nas-ha/)

## Ressources

* [www.digitalocean.com - Comment mettre en place des volumes persistants de ReadWriteMany (RWX) avec NFS sur les kubernetes de DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-set-up-readwritemany-rwx-persistent-volumes-with-nfs-on-digitalocean-kubernetes-fr)

