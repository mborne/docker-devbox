# OpenSearch

Containers running [OpenSearch](https://opensearch.org/) and [OpenSearch Dashboards](https://opensearch.org/docs/latest/dashboards/) for **DEV purpose**.

## System requirements

* [max_map_count >= 262144](../docs/max_map_count.md)

## Usage with docker

**WARNING** : Read [docker-compose.yml](docker-compose.yml) and note that **security is disabled**!

* Start containers : `docker compose up -d`
* Open https://os-dashboard.dev.localhost/

## Usage with Kubernetes

Read [k8s-install.sh](k8s-install.sh) and run :

```bash
# To get opensearch-dashboards on http://opensearch-dashboards.dev.localhost
bash k8s-install.sh
# To get opensearch-dashboards on http://opensearch-dashboards.example.net
DEVBOX_HOSTNAME=example.net bash k8s-install.sh
```

## Resources

* [opensearch.org - Install OpenSearch / Docker](https://opensearch.org/docs/latest/opensearch/install/docker/)

* [bitnami/opensearch - parameters](https://github.com/bitnami/charts/tree/main/bitnami/opensearch/#parameters)

