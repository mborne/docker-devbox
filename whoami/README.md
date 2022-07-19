# whoami

[containous/whoami](https://hub.docker.com/r/containous/whoami/dockerfile) image that outputs information about the machine it is deployed on (its IP address, host, and so on)

## Usage with docker-compose

* Start 2 instances : `docker-compose up -d --scale whoami=2`
* Open https://whoami.dev.localhost and refresh

## Usage with kustomize

```bash
# http://whoami.localhost
kubectl apply -k https://github.com/mborne/docker-devbox/whoami/manifest/base
# http://whoami.vagrantbox.dev
kubectl apply -k https://github.com/mborne/docker-devbox/vagrantbox/manifest/devbox
```

See [manifest/vagrantbox/kustomization.yaml](./manifest/vagrantbox/kustomization.yaml) and [manifest/vagrantbox/ingress-patch.json](./manifest/vagrantbox/ingress-patch.json) to customize hostname.
