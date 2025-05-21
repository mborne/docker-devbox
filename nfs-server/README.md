# nfs-server

Container running NFS server (`registry.k8s.io/volume-nfs:0.8`) for debug purpose.

## Alternatives

* [Setup an NFS server with nfs-kernel-server](https://documentation.ubuntu.com/server/how-to/networking/install-nfs/index.html) (see [github.com - mborne/ansible-nfs-server](https://github.com/mborne/ansible-nfs-server#readme)).
* SaaS solutions ([Google Filestore](https://cloud.google.com/filestore), [OVHcloud NAS-HA](https://www.ovhcloud.com/en/storage-solutions/nas-ha/),...)

## Usage with docker

```bash
# Start NFS server
docker compose up -d
# Retrieve IP
NFS_SERVER_IP=$(docker inspect nfs_server | jq -r '.[].NetworkSettings.Networks.devbox.IPAddress')
# show exports
showmount -e $NFS_SERVER_IP
```

## Usage with Kubernetes

> **Warning : In most Kubernetes clusters, nodes cannot resolve nfs-server.nfs-system.svc.cluster.local**

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
bash k8s-install.sh
```

## Ressources

* [developer.harness.io - Sample permanent volume - NFS server](https://developer.harness.io/docs/platform/delegates/delegate-reference/yaml/sample-create-a-permanent-volume-nfs-server/)


