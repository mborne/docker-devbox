# kind (Kubernetes in docker)

Helper to create a local [Kubernetes in docker (kind)](https://kind.sigs.k8s.io/) cluster.

## Installation

See [kind.sigs.k8s.io - Quick Start](https://kind.sigs.k8s.io/docs/user/quick-start/).

## Usage

```bash
# Create devbox cluster
kind create cluster --config config/basic.yaml
# Use the cluster...
kubectl get nodes
# Delete the cluster
kind delete clusters devbox
```

## Ressources

* [kind.sigs.k8s.io - Quick Start](https://kind.sigs.k8s.io/docs/user/quick-start/)
* [kind.sigs.k8s.io - Installing MetalLB using default manifests](https://kind.sigs.k8s.io/docs/user/loadbalancer/#installing-metallb-using-default-manifests)

> See `bash install-metallb.sh`

