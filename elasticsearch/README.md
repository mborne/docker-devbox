# Elasticsearch

Containers running [Elasticsearch](https://www.elastic.co/elasticsearch/) for **DEV purpose**.

## System requirements

* [max_map_count >= 262144](../docs/max_map_count.md)

## Usage with docker

* Start elasticsearch : `docker compose up -d`
* Open https://es.dev.localhost or https://es.dev.localhost/_cat/nodes?v&pretty

* Disable disk quota / watermark

```bash
bash disable-quota.sh
```

## Usage with Kubernetes

See [www.elastic.co - Download Elastic Cloud on Kubernetes](https://www.elastic.co/fr/downloads/elastic-cloud-kubernetes) :

```bash
# elastic definitions
kubectl create -f https://download.elastic.co/downloads/eck/2.5.0/crds.yaml
# elastic operator
kubectl apply -f https://download.elastic.co/downloads/eck/2.5.0/operator.yaml
```

...and usage in [geonetwork/manifest/base/elasticsearch.yaml](../geonetwork/manifest/base/elasticsearch.yaml) / [geonetwork/manifest/base/statefulset.yaml](../geonetwork/manifest/base/statefulset.yaml)


## Troubleshooting

### vm.max_map_count too low

> [1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

```bash
sudo sysctl -w vm.max_map_count=262144
```

### Disable disk quota / watermark

```bash
bash disable-quota.sh
```


## Resources

* [Install Elasticsearch with Docker](https://www.elastic.co/guide/en/elasticsearch/reference/7.15/docker.html#docker)
* [How to disable ElasticSearch disk quota / watermark](https://techoverflow.net/2019/04/17/how-to-disable-elasticsearch-disk-quota-watermark/) : avoid read-only problems

