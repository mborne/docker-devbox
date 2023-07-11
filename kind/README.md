# kind (Kubernetes in docker)

Helper to create a local [Kubernetes in docker (kind)](https://kind.sigs.k8s.io/) cluster.

## Requirements

* docker
* [kind](https://kind.sigs.k8s.io/docs/user/quick-start/)

## Getting started

You may use the [basic](config/basic.yaml) sample config :

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
  * [nginx-ingress-controller - Usage with Kind](../nginx-ingress-controller/README.md#usage-with-kind)


## Usage with Ingress and OIDC

A [config/generate.sh](config/generate.sh) is available to generate config with some options :

```bash
export WORKER_COUNT=3
export INGRESS_READY=0

export OIDC_ISSUER_URL=https://keycloak.quadtreeworld.net/realms/master

# Delete cluster if exists
kind create clusters devbox

# Generate config to create kind cluster
bash config/generate.sh | kind create cluster --config -
```

## Ressources

* [kind.sigs.k8s.io - Quick Start](https://kind.sigs.k8s.io/docs/user/quick-start/)
* [kind.sigs.k8s.io - Installing MetalLB using default manifests](https://kind.sigs.k8s.io/docs/user/loadbalancer/#installing-metallb-using-default-manifests)

> See `bash install-metallb.sh`

* [kind.sigs.k8s.io - Setting Up An Ingress Controller](https://kind.sigs.k8s.io/docs/user/ingress/#setting-up-an-ingress-controller)

