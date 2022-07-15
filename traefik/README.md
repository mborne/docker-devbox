# Traefik

## Description

Auto-configured reverse proxy according to container labels.

## Usage with docker

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
helm repo add traefik https://helm.traefik.io/traefik

helm repo update

kubectl create namespace traefik-v2

helm -n traefik-v2 install traefik traefik/traefik
# or 
# helm -n traefik-v2 install traefik traefik/traefik -f traefik/helm/qtw-dev-values.yml
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
