# whoami

[containous/whoami](https://hub.docker.com/r/containous/whoami/dockerfile) image that outputs information about the machine it is deployed on (its IP address, host, and so on)

## Usage

* Start 2 instances : `docker-compose up -d --scale whoami=2`
* Open http://whoami.localhost and refresh

## Usage with kustomize

```bash
kubectl apply -k https://github.com/mborne/docker-devbox/whoami/manifest
```

See [custom-domain/kustomization.yaml](custom-domain/kustomization.yaml) and [custom-domain/ingress-patch.json](custom-domain/ingress-patch.json) to customize hostname.
