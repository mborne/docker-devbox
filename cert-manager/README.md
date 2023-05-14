# cert-manager

Deploy [cert-manager](https://cert-manager.io/) with [bitnami's helm chart](https://bitnami.com/stack/cert-manager/helm) to generate TLS certificates.

## Usage with Kubernetes

Read [k8s-install.sh](k8s-install.sh) and run :

```bash
bash k8s-install.sh
```

Follow instructions providing links to the documentation to configure [Issuers and ClusterIssuers](https://cert-manager.io/docs/concepts/issuer/) and [Ingress resources](https://cert-manager.io/docs/tutorials/acme/nginx-ingress/#step-7---deploy-a-tls-ingress-resource).

## ClusterIssuer examples

### mkcert

For **DEV purpose**, see [cluster-issuer/mkcert.sh](cluster-issuer/mkcert.sh) to create a ["mkcert"](https://github.com/FiloSottile/mkcert) ClusterIssuer :

```bash
bash cluster-issuer/mkcert.sh
```

### LetsEncrypt

> Coming soon...

## Ingress example

See [whoami/k8s-install.sh](../whoami/k8s-install.sh) :

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

* [cert-manager - Documentation](https://cert-manager.io/docs/)
* [bitnami.com - cert-manager packaged by Bitnami helm charts](https://bitnami.com/stack/cert-manager/helm)
