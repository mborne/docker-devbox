# nginx-ingress-controller

Deploy [NGINX Ingress Controller](https://docs.nginx.com/nginx-ingress-controller/).

## Usage with Docker

Not implemented. See [Traefik](../traefik/README.md) or [jwilder/nginx-proxy](https://hub.docker.com/r/jwilder/nginx-proxy).

## Usage with Kubernetes

> **WARNING** : A service of type LoadBalancer will be created and a public IP will be claimed. See [Usage with Kind](#usage-with-kind) to deploy a NodePort service with local port mapping.

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
bash k8s-install.sh
```

* Use `ingressClassName: nginx` on Ingress resources

```bash
# in whoami directory :
DEVBOX_INGRESS=nginx bash k8s-install.sh
```

## Usage with Kind

* [Create kind cluster with ingress-ready config](../kind/README.md#usage-with-ingress)
* Use [helm/kind.yml](helm/kind.yml) values to deploy with helm :

```bash
NGINX_MODE=kind bash k8s-install.sh
```

## Resources

* [kubernetes.github.io - Ingress-Nginx Controller](https://kubernetes.github.io/ingress-nginx)
* [kubernetes.github.io - ingress-nginx - Installation Guide / QuickStart](https://kubernetes.github.io/ingress-nginx/deploy/#quick-start)
