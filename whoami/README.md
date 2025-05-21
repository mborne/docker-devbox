# whoami

Container running [traefik/whoami)](https://hub.docker.com/r/traefik/whoami) to discover [traefik](../traefik/README.md) :

![whoami-screenshot](docs/whoami-screenshot.png)

## Usage with docker

* Start 2 instances : `docker compose up -d --scale whoami=2`
* Open [http://whoami.dev.localhost](http://whoami.dev.localhost), refresh multiple times and note that "Hostname" (*the container id*) is changing as traefik is load balancing on the 2 instances.

## Usage with Kubernetes

Read [whoami/k8s-install.sh](k8s-install.sh) and run :

```bash
# To get whoami on http://whoami.dev.localhost
bash whoami/k8s-install.sh
# To get whoami on http://whoami.example.net
DEVBOX_HOSTNAME=example.net bash whoami/k8s-install.sh
```

## Ressources

* [github.com - mborne/helm-charts - whoami](https://github.com/mborne/helm-charts/tree/main/whoami#readme)



