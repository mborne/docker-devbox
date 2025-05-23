# Grafana

Container running [Grafana](https://grafana.com/) with datasources and dashboards auto-provisionning for [Loki](../loki/README.md) and [Prometheus](../prometheus/README.md).

## Parameters

| Name                     | Description                   | Value        |
| ------------------------ | ----------------------------- | ------------ |
| `GRAFANA_ADMIN_PASSWORD` | Grafana `admin` user password | `"ChangeIt"` |

## Usage with docker

* Start grafana : `docker compose up -d`
* Open https://grafana.dev.localhost/
* Login with "admin" / "ChangeIt"
* See prometheus and loki datasources : https://grafana.dev.localhost/connections/datasources
* See sample dashboards : https://grafana.dev.localhost/dashboards
* Import [some dashboards](#some-dashboards)

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

Prometheus & Node

* [6126 - Node Dashboard](https://grafana.com/grafana/dashboards/6126)
* [1860 - Node Exporter Full](https://grafana.com/grafana/dashboards/1860)

Prometheus & Blackbox Exporter :

* [7587 - Prometheus Blackbox Exporter](https://grafana.com/grafana/dashboards/7587-prometheus-blackbox-exporter/)
* [13659 - Blackbox Exporter (HTTP prober)](https://grafana.com/grafana/dashboards/13659-blackbox-exporter-http-prober/)

Prometheus & Traefik :

* [17346 - Traefik Official Standalone Dashboard](https://grafana.com/grafana/dashboards/17346-traefik-official-standalone-dashboard/)

Prometheus & Kubernetes :

* [8171 - Kubernetes Nodes](https://grafana.com/grafana/dashboards/8171-kubernetes-nodes/)
* [6417 - Kubernetes Cluster (Prometheus)](https://grafana.com/grafana/dashboards/6417-kubernetes-cluster-prometheus/)
* [315 - Kubernetes cluster monitoring (via Prometheus)](https://grafana.com/grafana/dashboards/315-kubernetes-cluster-monitoring-via-prometheus/)
* [15758 - Kubernetes / Views / Namespaces](https://grafana.com/grafana/dashboards/15758-kubernetes-views-namespaces/)

Nginx Ingress Controller :

* [12575 - Kubernetes Ingress Controller Dashboard](https://grafana.com/grafana/dashboards/12575-kubernetes-ingress-controller-dashboard/)

Loki :

* [13639 - Logs App](https://grafana.com/grafana/dashboards/13639-logs-app/) for Docker
* [15141 - Loki Kubernetes Logs](https://grafana.com/grafana/dashboards/15141-kubernetes-service-logs/)
* [All loki dashboards](https://grafana.com/grafana/dashboards/?search=loki)

Kyverno :

* [13995 - PolicyReport Details](https://grafana.com/grafana/dashboards/13995-policyreport-details/)

[x509-certificate-exporter](../x509-certificate-exporter/README.md) :

* [13922 - Certificates Expiration (X509 Certificate Exporter)](https://grafana.com/grafana/dashboards/13922-certificates-expiration-x509-certificate-exporter/)


## Ressources

* [github.com/grafana/helm-charts - Grafana Helm Chart](https://github.com/grafana/helm-charts/blob/main/charts/grafana/README.md#grafana-helm-chart)
