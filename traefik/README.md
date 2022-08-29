# Traefik

Container running [traefik proxy](https://doc.traefik.io/traefik/).

## Usage with docker-compose

* Create certs for `*.dev.localhost` using [mkcerts](https://github.com/FiloSottile/mkcert#mkcert) :

```bash
mkcert -cert-file certs/default.pem -key-file certs/default-key.pem *.dev.localhost dev.localhost localhost
```

* Start traefik : `docker-compose up -d`

* See https://traefik.dev.localhost for web-ui

* Run [whoami](../whoami/README.md) to test traefik

## Usage with kustomize

**WARNING : Mainly written to understand traefik some points in traefik. Prefer the use the official helm chart [traefik/traefik-helm-chart](https://github.com/traefik/traefik-helm-chart#traefik)**

```bash
# http://traefik.localhost (dashboard)
kubectl apply -k https://github.com/mborne/docker-devbox/traefik/manifest
```

## Usage with helm

See [traefik/traefik-helm-chart](https://github.com/traefik/traefik-helm-chart#traefik) :

```bash
# add helm repository
helm repo add traefik https://helm.traefik.io/traefik
# update helm repositories
helm repo update
# create a namespace for traefik
kubectl create namespace traefik-system
# install traefik with helm
helm -n traefik-system install traefik traefik/traefik
# to use custom values :
# helm -n traefik-system install traefik traefik/traefik -f traefik/helm/qtw-dev-values.yml
```

Dashboard access :

```bash
# http://localhost:9000/dashboard/#/
kubectl -n traefik-system port-forward $(kubectl -n traefik-system get pods -o name) 9000:9000
```

## Reference

Docker :

* [knplabs.com - How to handle https with docker-compose and mkcert for local development](https://knplabs.com/en/blog/how-to-handle-https-with-docker-compose-and-mkcert-for-local-development)
* [traefik.io - blog - Traefik Proxy 2.x and TLS 101](https://traefik.io/blog/traefik-2-tls-101-23b4fbee81f1/)

Kubernetes :

* [Traefik & Kubernetes](https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/)
* [blog.tomarrell.com - Kustomize: Traefik v2.2 as a Kubernetes Ingress Controller](https://blog.tomarrell.com/post/traefik_v2_on_kubernetes)
* [www.grottedubarbu.fr - Traefik 2.2 + K3S](https://www.grottedubarbu.fr/traefik-2-k3s/)
* [www.grottedubarbu.fr - Kubernetes : Kustomize & Traefik](https://www.grottedubarbu.fr/kubernetes-kustomize-traefik/)
