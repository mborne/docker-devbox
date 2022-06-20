# Traefik

## Description

Auto-configured reverse proxy according to container labels.

## Usage with docker

* Start traefik : `docker-compose up -d`

* See http://traefik.localhost for web-ui

* Run [whoami](../whoami/README.md) to test traefik

## Usage with kustomize

```bash
# http://traefik.localhost (dashboard)
kubectl apply -k https://github.com/mborne/docker-devbox/traefik/manifest
```

## Reference

* [Traefik & Kubernetes](https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/)
* [blog.tomarrell.com - Kustomize: Traefik v2.2 as a Kubernetes Ingress Controller](https://blog.tomarrell.com/post/traefik_v2_on_kubernetes)
* [www.grottedubarbu.fr - Traefik 2.2 + K3S](https://www.grottedubarbu.fr/traefik-2-k3s/)
