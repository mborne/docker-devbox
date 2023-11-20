# Grafana

Container running [Grafana Loki](https://grafana.com/docs/loki/latest/) and [Grafana Promtail](https://grafana.com/docs/loki/latest/send-data/promtail/).

## Usage with docker

* Start stack : `docker compose up -d`
* See pre-configured Loki datasource in [Grafana](../grafana/README.md)

## Usage with Kubernetes

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
bash k8s-install.sh
```

* See pre-configured Loki datasource in [Grafana](../grafana/README.md)

## Ressources

* [grafana.com - Install the monolithic Helm chart](https://grafana.com/docs/loki/latest/setup/install/helm/install-monolithic/)

