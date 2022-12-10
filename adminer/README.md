# adminer

Container running [adminer](https://hub.docker.com/_/adminer/).

## Usage with docker

* Start adminer : `docker-compose up -d`
* Open https://adminer.dev.localhost/

## Usage with Kubernetes

* Create namespace : `kubectl create namespace adminer`
* Deploy adminer : `kubectl -n adminer apply -k adminer/manifest/base`
* Open https://adminer.dev.localhost/

## Login to database

With [PostGIS deployed with Kustomize](../postgis/README.md#usage-with-kustomize) :

![Login form](img/adminer-login.png)

