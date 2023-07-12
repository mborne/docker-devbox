# kind (Kubernetes in docker)

Helper to create a local [Kubernetes in docker (kind)](https://kind.sigs.k8s.io/) cluster.

## Requirements

* docker
* [kind](https://kind.sigs.k8s.io/docs/user/quick-start/)

## Getting started

You may use the [basic](config/basic.yaml) sample config to create the first cluster :

```bash
# Create devbox cluster
kind create cluster --config config/basic.yaml
# Use the cluster...
kubectl get nodes
# Delete the cluster
kind delete clusters devbox
```


## Usage with Ingress

Note that **[setting Up An Ingress Controller](https://kind.sigs.k8s.io/docs/user/ingress/#setting-up-an-ingress-controller) requires some work with kind**. See [kind/quickstart.sh - Kind with Ingress and more...](quickstart.md) to automate the following steps :

* Create kind cluster using [ingress-ready config](config/ingress-ready.yaml) which allows setup of an ingress controller in the control plane :

```bash
# Create devbox cluster
kind create cluster --config config/ingress-ready.yaml
```

* Install ingress controller with the corresponding config, see :
  * [traefik - Usage with Kind](../traefik/README.md#usage-with-kind)
  * [nginx-ingress-controller - Usage with Kind](../nginx-ingress-controller/README.md#usage-with-kind)


## Ressources

* [kind.sigs.k8s.io - Quick Start](https://kind.sigs.k8s.io/docs/user/quick-start/)
* [kind.sigs.k8s.io - Installing MetalLB using default manifests](https://kind.sigs.k8s.io/docs/user/loadbalancer/#installing-metallb-using-default-manifests)

> See `bash install-metallb.sh`

* [kind.sigs.k8s.io - Setting Up An Ingress Controller](https://kind.sigs.k8s.io/docs/user/ingress/#setting-up-an-ingress-controller)

