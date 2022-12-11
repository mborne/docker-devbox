# [Netdata](https://www.netdata.cloud/)

Container running [netdata/netdata](https://hub.docker.com/r/netdata/netdata) image.

## Usage with docker

* Start instance : `NETDATA_NAME=${HOSTNAME} docker compose up -d`
* Open https://netdata.dev.localhost or http://localhost:19999

## Usage with Kubernetes

See [learn.netdata.cloud - Deploy Kubernetes monitoring with Netdata](https://learn.netdata.cloud/docs/agent/packaging/installer/methods/kubernetes) :

* Add helm repository : `helm repo add netdata https://netdata.github.io/helmchart/`
* Update helm repositories : `helm repo update`
* Create namespace : `kubectl create namespace netdata`
* Update help repositories : `helm -n netdata install -f netdata/helm/values.yaml netdata netdata/netdata`





