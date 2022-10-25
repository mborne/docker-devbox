# Longhorn

[Longhorn](https://longhorn.io/) is a cloud native distributed block storage for Kubernetes :


![Longhorn nodes](img/longhorn-nodes.png)


## System requirements

```bash
sudo apt-get install open-iscsi
sudo systemctl start iscsid && sudo systemctl enable iscsid
sudo systemctl status iscsid
```

## Usage with kustomize

* Deploy to k8s

```bash
kubectl apply -k https://github.com/mborne/docker-devbox/longhorn/manifest
```

* Edit number of replicates if you don't have at least 3 nodes :

```bash
kubectl -n longhorn-system edit cm/longhorn-storageclass
```

* Check pod status : `watch kubectl -n longhorn-system get pods -w`

* Open UI : https://longhorn.dev.localhost and check nodes.

* [Ensure that you have only one default StorageClass](https://kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/#changing-the-default-storageclass) :

```bash
kubectl get storageclass -o wide
# for longhorn with K3S
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
```

## Usage in client application

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: test-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: longhorn
  resources:
    requests:
      storage: 1Gi
```

## See also

* [Container Storage Interface (CSI) drivers list](https://kubernetes-csi.github.io/docs/drivers.html)

## Ressources

* [Installing K3s with Longhorn and USB storage on Raspberry Pi](https://www.jericdy.com/blog/installing-k3s-with-longhorn-and-usb-storage-on-raspberry-pi)
* [cloudolife.com - Helm install Rancher Labs Longhorn Cloud Native distributed block storage for Kubernetes](https://cloudolife.com/2020/10/03/Kubernetes-K8S/Helm/Helm-install-Rancher-Labs-Longhorn-Cloud-Native-distributed-block-storage-for-Kubernetes-K8S/)
