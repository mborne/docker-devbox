# Kind with Ingress Controller and more...

Helper to create a local [Kubernetes in docker (kind)](https://kind.sigs.k8s.io/) cluster with Ingress, NetworkPolicy support (with canal or calico) and RWX PersistentVolume (with extraMounts).

## Requirements

* docker
* [kind](https://kind.sigs.k8s.io/docs/user/quick-start/)
* Free port 80 and 443

## Description

[kind/quickstart.sh](quickstart.sh) script performs the following operations :

* Create a kind cluster with a generated configuration including :
  * `extraPortMappings` to deploy ingress controller on the master node (like [config/ingress-ready.yaml](config/ingress-ready.yaml))
  * `extraMounts` of `/var/devbox` on `/devbox` for each node (see [PV and PVC in docs/nginx-rwx.yml](docs/nginx-rwx.yml))
  * OIDC authentication
* Optionally install custom CNI (canal or calico)
* Install [metric-server](kind/metric-server/kustomization.yaml)
* Install [cert-manager](../cert-manager/README.md) with a mkcert cluster issuer (if locally available)
* Install [traefik](../traefik/README.md#usage-with-kind) or [nginx-ingress-controller](../nginx-ingress-controller/README.md#usage-with-kind) with kind compatible config
* Install [whoami](../whoami/README.md#usage-with-kubernetes) sample app (https://whoami.dev.localhost)
* Install [kubernetes-dashboard](../kubernetes-dashboard/README.md#usage-with-kubernetes) (https://kube-dashboard.dev.localhost)

## Usage

```bash
# use nginx-ingress-controller instead of traefik
export DEVBOX_INGRESS=nginx
# enable OIDC auth on Kubernetes API 
export OIDC_ISSUER_URL=https://keycloak.quadtreeworld.net/realms/master
# use a mirror for dockerhub
export DOCKERHUB_PROXY=https://docker-mirror.quadtreeworld.net

# Install custom CNI
#export DISABLE_DEFAULT_CNI=true
export USE_CANAL=1
#export USE_CALICO=1

# Delete cluster if exists
kind delete clusters devbox

# Create kind cluster and deploy
bash kind/quickstart.sh
```

## How it works?

An helper script ( [kind/config/generate.sh](config/generate.sh) ) allows to generate kind with some options :

```bash
# Number of worker nodes
export WORKER_COUNT=3
# Enable 80 and 443 port exposure 
export INGRESS_READY=1
# Enable
export OIDC_ISSUER_URL=https://keycloak.quadtreeworld.net/realms/master

# Generate config to create kind cluster
bash kind/config/generate.sh
```


## Ressources

* [kind.sigs.k8s.io - Quick Start](https://kind.sigs.k8s.io/docs/user/quick-start/)
* [kind.sigs.k8s.io - Setting Up An Ingress Controller](https://kind.sigs.k8s.io/docs/user/ingress/#setting-up-an-ingress-controller)
    * [config/ingress-ready.yaml](config/ingress-ready.yaml)
    * [traefik - Usage with Kind](../traefik/README.md#usage-with-kind)
    * [nginx-ingress-controller - Usage with Kind](../nginx-ingress-controller/README.md#usage-with-kind)
* [kind.sigs.k8s.io - Installing MetalLB using default manifests](https://kind.sigs.k8s.io/docs/user/loadbalancer/#installing-metallb-using-default-manifests)
  * See [metallb-install.sh](metallb-install.sh) where a ".0/24" subnet is required for kind
