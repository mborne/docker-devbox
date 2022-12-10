# GeoNetwork (CSW, CSW-T)

Container running [GeoNetwork](https://geonetwork-opensource.org/).

## Usage with docker

* Start [Elasticsearch](../elasticsearch/README.md#usage-with-docker-compose)
* Start geonetwork : `docker-compose up -d`
* Open https://geonetwork.dev.localhost/geonetwork/
* Login with admin/admin

## Usage with Kubernetes

* Install [CRD and Operator for Elasticsearch](../elasticsearch/README.md#usage-with-kubernetes).
* Create namespace : `kubectl create namespace geonetwork`
* Deploy geonetwork : `kubectl -n geonetwork apply -k https://github.com/mborne/docker-devbox/geonetwork/manifest/base`
* Open https://geonetwork.dev.localhost/geonetwork/
