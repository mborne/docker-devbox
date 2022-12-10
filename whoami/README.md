# whoami

Container running [containous/whoami](https://hub.docker.com/r/containous/whoami/dockerfile) to discover [traefik](../traefik/README.md).

## Usage with docker

* Start 2 instances : `docker-compose up -d --scale whoami=2`
* Open https://whoami.dev.localhost and refresh

## Usage with Kubernetes

```bash
# create namespace
kubectl create namespace whoami

# http://whoami.dev.localhost
kubectl -n whoami apply -k https://github.com/mborne/docker-devbox/whoami/manifest/base
# https://whoami.dev.quadtreeworld.net
kubectl -n whoami apply -k https://github.com/mborne/docker-devbox/whoami/manifest/qtw-dev
# https://whoami.poc-k8s.quadtreeworld.net
kubectl -n whoami apply -k https://github.com/mborne/docker-devbox/whoami/manifest/poc-k8s
```

See [manifest/vagrantbox/kustomization.yaml](./manifest/vagrantbox/kustomization.yaml) and [manifest/vagrantbox/ingress-patch.json](./manifest/vagrantbox/ingress-patch.json) to customize hostname.
