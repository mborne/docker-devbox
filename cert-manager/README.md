# cert-manager

## Usage with Kubernetes

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
# To get whoami on http://whoami.dev.localhost
bash k8s-install.sh
```

* Follow instructions :

>** Please be patient while the chart is being deployed **
>
> In other to begin using certificates, you will need to set up Issuer or ClustersIssuer resources.
>
> https://cert-manager.io/docs/configuration/
>
>To configure a new ingress to automatically provision certificates, you will find some information in the following link:
>
> https://cert-manager.io/docs/usage/ingress/

## ClusterIssuer examples

### mkcert CA

* Read [cluster-issuer/mkcert.sh](cluster-issuer/mkcert.sh) and run :

```bash
# To get whoami on http://whoami.dev.localhost
bash cluster-issuer/mkcert.sh
```

* See [whoami/k8s-install.sh](../whoami/k8s-install.sh) example :

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: whoami
  annotations:
    cert-manager.io/cluster-issuer: "mkcert"
spec:
  ingressClassName: nginx
  rules:
  - host: whoami.dev.localhost
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: whoami
            port:
              number: 80
  tls:
  - hosts:
    - whoami.dev.localhost
    secretName: whoami-cert
```


## Resources

* [bitnami.com - CERT-MANAGER PACKAGED BY BITNAMI HELM CHARTS](https://bitnami.com/stack/cert-manager/helm)
