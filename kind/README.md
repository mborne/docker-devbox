# kind (Kubernetes in docker)

Helper to create a local [Kubernetes in docker (kind)](https://kind.sigs.k8s.io/) cluster.

## Installation

See [kind.sigs.k8s.io - Quick Start](https://kind.sigs.k8s.io/docs/user/quick-start/).

## Usage

To get started, you may use the [basic](config/basic.yaml) sample config :

```bash
# Create devbox cluster
kind create cluster --config config/basic.yaml
# Use the cluster...
kubectl get nodes
# Delete the cluster
kind delete clusters devbox
```

## Usage with Ingress

* Create kind cluster using [ingress-ready](config/ingress-ready.yaml) sample config which allows setup of an ingress controller in the control plane :

```bash
# Create devbox cluster
kind create cluster --config config/ingress-ready.yaml
```

* Install ingress controller with the corresponding config, see :
  * [traefik - Usage with Kind](../traefik/README.md#usage-with-kind)


## Ressources

* [kind.sigs.k8s.io - Quick Start](https://kind.sigs.k8s.io/docs/user/quick-start/)
* [kind.sigs.k8s.io - Installing MetalLB using default manifests](https://kind.sigs.k8s.io/docs/user/loadbalancer/#installing-metallb-using-default-manifests)

> See `bash install-metallb.sh`

* [kind.sigs.k8s.io - Setting Up An Ingress Controller](https://kind.sigs.k8s.io/docs/user/ingress/#setting-up-an-ingress-controller)

