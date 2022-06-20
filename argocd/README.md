

# argocd

## Usage with kustomize

* Start Argo CD :

```bash
# http://argocd.localhost
kubectl apply -k argocd/manifest/base
```

* Retrieve initial admin password :

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

* Add some apps (see [argoproj/argocd-example-apps](https://github.com/argoproj/argocd-example-apps))

## Warning

This setup doesn't works where http_proxy and https_proxy is required on containers. See [github.com - Setting proxy in argocd server](https://github.com/argoproj/argo-cd/issues/2954#issuecomment-843260694) and helm chart.

## Ressources

* [argo-cd.readthedocs.io - Getting Started](https://argo-cd.readthedocs.io/en/stable/getting_started/)
* [argo-cd.readthedocs.io - Manage Argo CD Using Argo CD](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#manage-argo-cd-using-argo-cd) (example of kustomization)
