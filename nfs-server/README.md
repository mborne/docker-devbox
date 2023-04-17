# nfs-server

Container running NFS server (k8s.gcr.io/volume-nfs:0.8) for debug purpose.

## Usage with docker

```bash
# Start NFS server
docker compose up -d
# Retrieve IP
NFS_SERVER_IP=$(docker inspect nfs_server | jq -r '.[].NetworkSettings.Networks.devbox.IPAddress')
# show exports
showmount -e $NFS_SERVER_IP
```

## Ressources

* https://developer.harness.io/docs/platform/delegates/delegate-reference/yaml/sample-create-a-permanent-volume-nfs-server/


