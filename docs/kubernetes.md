# Usage with Kubernetes

## Requirements

* [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
* [helm](https://helm.sh/docs/intro/install/)
* Configure kubectl to use a [DEV instance](kubernetes-dev.md)

## How it works in devbox?

A `k8s-deploy.sh` helper script is provided to :

* Create a namespace for the stack
* Deploy the stack either with [Kustomize](https://kustomize.io/) (`kubectl apply -k ...`) or [helm](https://helm.sh/) (`helm upgrade --install ...`)

This approach makes it possible to:

* Simplify calls to helm and kubectl
* Configure deployment with environment variables (ex : `DEVBOX_HOSTNAME=dev.my-domain.com`)


## Load Balancing

Stacks are created assuming the :

* [traefik](../traefik/README.md) or [nginx-ingress-controller](../nginx-ingress-controller/README.md) is deployed
* [cert-manager](../cert-manager/README.md) is deployed with a ClusterIssuer (it comes with create one of "mkcert", "letsencrypt-http" or "letsencrypt-dns")


The following environment variables provides some option for [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) resources creation :

| Name              | Description                                                                                   | Default value                                         |
| ----------------- | --------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| `DEVBOX_HOSTNAME` | The base domain use to expose applications (ex : `https://whoami.${DEVBOX_HOSTNAME}`)         | `dev.localhost`                                       |
| `DEVBOX_INGRESS`  | The `ingressClassName` to select an ingress controller                                        | [traefik](../traefik/README.md#usage-with-kubernetes) |
| `DEVBOX_ISSUER`   | The name of the [ClusterIssuer for cert-manager](https://cert-manager.io/docs/configuration/) | `mkcert`                                              |

The principle is illustrated bellow for https://whoami.dev.localhost :

```yml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: whoami
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: whoami.$DEVBOX_HOSTNAME
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
    - whoami.$DEVBOX_HOSTNAME
    secretName: whoami-cert
```

## Moving to production?

Note that :

* **You should not use resources from this repository!**
* You may have to deploy in an existing namespace provided by an administrator
* There are more advanced solutions than bash scripting to handle variables including [ArgoCD](../argocd/README.md), [GitLab-CI](https://docs.gitlab.com/ee/user/clusters/agent/ci_cd_workflow.html),...

## Resources

* [K3S](https://k3s.io) is quite trivial to setup on a single node


