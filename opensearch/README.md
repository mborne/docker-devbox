# OpenSearch

Containers running [OpenSearch](https://opensearch.org/) for **DEV purpose**.

## System requirements

* [max_map_count >= 262144](../docs/max_map_count.md)

## Usage with docker-compose

WARNING : Read [docker-compose.yml](docker-compose.yml) and note that **security is disabled**!

* Start containers : `docker compose up -d`
* Open https://os-dashboard.dev.localhost/

## Usage with helm

* Add helm chart : `helm repo add opensearch https://opensearch-project.github.io/helm-charts/`
* Update helm repositories : `helm repo update`
* Create namespace : `kubectl create namespace opensearch`
* Install OpenSearch : 

```bash
# With default values
helm -n opensearch install opensearch opensearch/opensearch
# or to disable TLS and basic auth :
#helm -n opensearch install -f opensearch/helm/insecure.yml opensearch opensearch/opensearch
```

* Watch all cluster members come up : `kubectl -n opensearch get pods -w`

* Access from host : `kubectl -n opensearch port-forward service/opensearch-cluster-master 19200:9200`
  * https://127.0.0.1:19200 using admin/admin with default values
  * http://127.0.0.1:19200 with [helm/insecure.yml](helm/insecure.yml) values

## Resources

* [opensearch.org - Install OpenSearch / Docker](https://opensearch.org/docs/latest/opensearch/install/docker/)
* [opensearch.org - Install OpenSearch using Helm](https://opensearch.org/docs/latest/opensearch/install/helm/#install-opensearch-using-helm)



