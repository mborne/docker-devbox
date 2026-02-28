# Kind - Quickstart with Ingress Controller and more...

Helper to create a realistic [Kubernetes in docker (kind)](https://kind.sigs.k8s.io/) cluster.

## Requirements

* docker
* [kind](https://kind.sigs.k8s.io/docs/user/quick-start/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
* [helm](https://helm.sh/docs/intro/install/)
* Free port 80 and 443

## Features

* Ingress support with [traefik](../traefik/README.md)
* Auto SSL certificates with [cert-manager](../cert-manager/README.md) 
* OIDC (optional)
* DockerHub proxy (optional) to avoid reaching [pull limit](https://docs.docker.com/docker-hub/usage/).
* Custom CNI (canal or calico) for NetworkPolicy support (optional).
* RWX PersistentVolume with `extraMounts` (`/var/devbox`).

## Parameters

The [kind/quickstart.sh](quickstart.sh) scripts supports the following environment values :

| Name                        | Description                                                                                                  | Default value                   |
| --------------------------- | ------------------------------------------------------------------------------------------------------------ | ------------------------------- |
| `KIND_CLUSTER_NAME`         | The name of the kind cluster                                                                                 | `devbox`                        |
| `KIND_WORKER_COUNT`         | The number of worker node                                                                                    | `3`                             |
| `KIND_CNI`                  | Customize CNI using "default", "calico" or "canal" (note that default doesn't supports NetworkPolicies)      | `default`                       |
| `KIND_ADMISSION_PLUGINS`    | Allows to customize admission plugins                                                                        | `NodeRestriction,ResourceQuota` |
| `DEVBOX_INGRESS` (1)        | Allows to install either [traefik](../traefik/README.md)                                                     | `traefik`                       |
| `KIND_INGRESS_READY`        | Allows to disable `extraPortMappings` on ports 80 and 443                                                    | `1`                             |
| `DOCKERHUB_PROXY`           | Allows to use a mirror for DockerHub (ex : https://mirror.gcr.io from Google)                                | `""`                            |
| `KIND_OIDC_ISSUER_URL` (2)  | URL of the OIDC provider (ex : `https://keycloak.example.com/realms/master`), if empty OIDC will be disabled | `""`                            |
| `KIND_OIDC_CLIENT_ID`       | Required value used to check **audience** in OIDC token                                                          | `"kubernetes"`                  |
| `KIND_OIDC_USERNAME_CLAIM`  | Name of the claim in OIDC token to use as **username**                                                           | `"email"`                       |
| `KIND_OIDC_USERNAME_PREFIX` | Prefix to add to username from OIDC token                                                                    | `"odic:"`                       |
| `KIND_OIDC_GROUPS_PREFIX`   | Prefix to add to group names from OIDC token                                                                 | `"odic:"`                       |

> (1) Note that `k8s-install.sh` must use the same value.
> (2) Do not add useless "/" (`${KIND_OIDC_ISSUER_URL}/.well-known/openid-configuration` must exists)

## Usage

```bash
# Delete cluster if exists
kind delete clusters devbox

# Create kind cluster and deploy
bash kind/quickstart.sh
```

## How it works?

The [kind/config/generate.sh](config/generate.sh) script allows to generate [kind configuration](https://kind.sigs.k8s.io/docs/user/configuration/) with some options :

```bash
# Number of worker nodes
export KIND_WORKER_COUNT=5
# enable OIDC auth on Kubernetes API 
export KIND_OIDC_ISSUER_URL=https://keycloak.quadtreeworld.net/realms/master
# IMPORTANT : Use a mirror for DockerHub (ex : mirror.gcr.io from Google)
# see also : https://docs.docker.com/docker-hub/image-library/mirror/#run-a-registry-as-a-pull-through-cache
export DOCKERHUB_PROXY=https://mirror.gcr.io
# Install custom CNI (required for NetworkPolicies)
# default, calico or canal
export KIND_CNI=calico

# Generate config to create kind cluster
bash kind/config/generate.sh
```

Note that :

* `extraPortMappings` is configured to **allow the deployment of an ingress controller on the master node** (like [config/ingress-ready.yaml](config/ingress-ready.yaml))
* `extraMounts` of `/var/devbox` on `/devbox` allows RWX PV creation (see [PV and PVC in docs/nginx-rwx.yml](docs/nginx-rwx.yml))

## Ressources

* [kind.sigs.k8s.io - Quick Start](https://kind.sigs.k8s.io/docs/user/quick-start/)
* [kind.sigs.k8s.io - Setting Up An Ingress Controller](https://kind.sigs.k8s.io/docs/user/ingress/#setting-up-an-ingress-controller)
    * [config/ingress-ready.yaml](config/ingress-ready.yaml)
    * [traefik - Usage with Kind](../traefik/README.md#usage-with-kind)
