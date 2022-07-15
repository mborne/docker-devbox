# netdata

[netdata/netdata](https://hub.docker.com/r/netdata/netdata) image monitoring performance and health.

## Usage with docker-compose

* Start instance : `NETDATA_NAME=${HOSTNAME} docker-compose up -d`
* Open http://netdata.localhost or http://localhost:19999

## Usage with Kubernetes

See [learn.netdata.cloud - Deploy Kubernetes monitoring with Netdata](https://learn.netdata.cloud/docs/agent/packaging/installer/methods/kubernetes)

```bash
helm repo add netdata https://netdata.github.io/helmchart/
helm install -f netdata/helm/values.yaml netdata netdata/netdata
```




