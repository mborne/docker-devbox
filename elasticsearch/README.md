# Elasticsearch

## Description

Docker container running [Elasticsearch](https://www.elastic.co/elasticsearch/) as a single node for dev purpose.

## Usage

* Start elasticsearch : `docker-compose up -d`
* Open http://es.localhost or http://es.localhost/_cat/nodes?v&pretty

## Usage with K8S

See [www.elastic.co - Download Elastic Cloud on Kubernetes](https://www.elastic.co/fr/downloads/elastic-cloud-kubernetes) :

```bash
kubectl create -f https://download.elastic.co/downloads/eck/2.2.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.2.0/operator.yaml
```

...and usage in [geonetwork/manifest/base/elasticsearch.yaml](../geonetwork/manifest/base/elasticsearch.yaml) / [geonetwork/manifest/base/statefulset.yaml](../geonetwork/manifest/base/statefulset.yaml)

## Troubleshooting

```bash
docker-compose logs -f
```

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

