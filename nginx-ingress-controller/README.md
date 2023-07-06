# nginx-ingress-controller

Deploy [NGINX Ingress Controller](https://docs.nginx.com/nginx-ingress-controller/) using [bitnami's helm chart](https://bitnami.com/stack/nginx-ingress-controller/helm).

## Usage with Kubernetes

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

* [github.com - bitnami/nginx-ingress-controller](https://github.com/bitnami/charts/tree/main/bitnami/nginx-ingress-controller/#nginx-ingress-controller-packaged-by-bitnami)
