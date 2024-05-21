# nfs-demo

Illustrates the use of a "nfs" storage class providing ReadWriteMany support.

## How it works?

* [manifest/pvc.yaml](manifest/pvc.yaml) claims a RWX PersistentVolume for nginx data
* [manifest/deployment.yaml](manifest/deployment.yaml) creates a nginx server
* [manifest/service.yaml](manifest/services.yaml) exposes nginx as services
* [manifest/cronjob.yaml](manifest/cronjob.yaml) periodically updates index.html

## Usage with Kubernetes

```bash
# Deploy nfs-demo
bash nfs-demo/k8s-install.sh

# Test service
kubectl -n nfs-demo run --rm -ti busybox --image=busybox --restart=Never -- /bin/sh -c "wget -q -O- http://nfs-demo"
```



