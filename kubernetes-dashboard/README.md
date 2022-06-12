# kubernetes-dashboard

## Usage with kustomize

* Deploy [kubernetes-dashboard](https://github.com/kubernetes/dashboard/) with an [admin-user](manifest/admin-user.yaml):

```bash
kubectl apply -k https://github.com/mborne/docker-devbox/kubernetes-dashboard/manifest
```


* Get admin-user token :

```bash
kubectl -n kubernetes-dashboard get secret \
    $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") \
    -o go-template="{{.data.token | base64decode}}"
```

* Start `kubectl proxy`
* Open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

## Reference

* [kubernetes.io - Tableau de bord (Dashboard)](https://kubernetes.io/fr/docs/tasks/access-application-cluster/web-ui-dashboard/)
* [github.com - kubernetes/dashboard](https://github.com/kubernetes/dashboard/)
