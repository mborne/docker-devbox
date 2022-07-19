# GeoNetwork (CSW, CSW-T)

Docker container running [GeoNetwork](https://geonetwork-opensource.org/).

## Usage with docker-compose

* Start geonetwork : `docker-compose up -d`

* Open https://geonetwork.dev.localhost/geonetwork/

* Login with admin/admin

## Usage with kustomize

Requirements : [elasticsearch - CRD and Operator](../elasticsearch/README.md#usage-with-kubernetes)

```bash
# https://geonetwork.localhost/geonetwork/
kubectl apply -k https://github.com/mborne/docker-devbox/geonetwork/manifest/base
```
