# kind/quickstart.sh - Kind with Ingress and more...

## Description

[kind/quickstart.sh](quickstart.sh) script performs the following operations :

* Create a kind cluster with a generated configuration
* Install [metric-server](kind/metric-server/kustomization.yaml)
* Install [cert-manager](../cert-manager/README.md) with a mkcert cluster issuer (if available)
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
# use canal (flannel + calico) instead of default CNI to test NetworkPolicies
export USE_CANAL=1

# Delete cluster if exists
kind delete clusters devbox

# Create kind cluster and deploy
bash kind/quickstart.sh
```

## How it works?

An helper script ( [kind/config/generate.sh](generate.sh) ) allows to generate kind with some options :

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
