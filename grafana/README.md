
## Usage with Kubernetes

Read [k8s-install.sh](k8s-install.sh) and run :

```bash
# To get grafana on http://grafana.dev.localhost
bash k8s-install.sh
# To get grafana on http://grafana.example.net
DEVBOX_HOSTNAME=example.net bash k8s-install.sh
```

* Retreive "admin" user password from secret

```bash
kubectl -n grafana get secrets grafana -o jsonpath='{ .data.admin-password }' | base64 -d
```


## Some dashboards

* [Node Dashboard (id=6126)](https://grafana.com/grafana/dashboards/6126)
* [Node Exporter Full (id=1860)](https://grafana.com/grafana/dashboards/1860)
* [Prometheus Blackbox Exporter (id=7587)](https://grafana.com/grafana/dashboards/7587-prometheus-blackbox-exporter/)
* [Traefik Official Standalone Dashboard (17346)](https://grafana.com/grafana/dashboards/17346-traefik-official-standalone-dashboard/)


## Ressources


* [github.com/grafana/helm-charts - Grafana Helm Chart](https://github.com/grafana/helm-charts/blob/main/charts/grafana/README.md#grafana-helm-chart)