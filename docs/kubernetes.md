# Notes about Kubernetes

## Key points

* [Kustomize](https://kustomize.io/) and [helm](https://helm.sh/) are used to manage configuration
* Deployments are mainly tested with [K3S](https://k3s.io) where default traefik setup is disabled.
* [Traefik](../traefik/README.md) is used to provide nice URL
* Get started with [whoami](../whoami/README.md)
* **WORK IN PROGRESS** (I'm still a noob)

## Ressources

* [K3S](https://k3s.io) is quite trivial to setup on a single node :

```bash
# install K3S
curl -sfL https://get.k3s.io | sh -s - --disable traefik --flannel-iface enp0s8
# configure permission
sudo setfacl -m "u:$USER:r" /etc/rancher/k3s/k3s.yaml
# configure kubectl
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
# check
kubectl cluster-info
kubectl get nodes
```

* You may have a look to [mborne/vagrantbox](https://github.com/mborne/vagrantbox) to create a local cluster with vagrant and ansible.


