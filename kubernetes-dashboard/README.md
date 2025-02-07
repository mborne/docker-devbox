# kubernetes-dashboard

Container running [Kubernetes Dashboard](https://github.com/kubernetes/dashboard/#kubernetes-dashboard) :

![kube-dashboard-screenshot.png](docs/kube-dashboard-screenshot.png)

## Usage with Kubernetes

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
# To get kubernetes-dashboard on https://dashboard.dev.localhost
bash k8s-install.sh
# To get kubernetes-dashboard on https://dashboard.example.net
DEVBOX_HOSTNAME=example.net bash k8s-install.sh
```

* Get admin-user token : `kubectl -n kubernetes-dashboard create token admin-user`

* Open https://dashboard.dev.localhost

## Resources

* [kubernetes.io - Tableau de bord (Dashboard)](https://kubernetes.io/fr/docs/tasks/access-application-cluster/web-ui-dashboard/)
* [github.com - kubernetes/dashboard](https://github.com/kubernetes/dashboard/)
