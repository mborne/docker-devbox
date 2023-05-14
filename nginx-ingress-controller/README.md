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


