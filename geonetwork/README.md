# GeoNetwork (CSW, CSW-T)

Container running [GeoNetwork](https://geonetwork-opensource.org/).

## Usage with docker

* Start geonetwork : `docker compose up -d`
* Open https://geonetwork.dev.localhost/geonetwork/
* Login with admin/admin

## Usage with Kubernetes

* Install [CRD and Operator for Elasticsearch](../elasticsearch/README.md#usage-with-kubernetes).
* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
# To get geonetwork on http://geonetwork.dev.localhost/geonetwork/
bash k8s-install.sh
# To get geonetwork on http://geonetwork.example.net/geonetwork/
DEVBOX_HOSTNAME=example.net bash k8s-install.sh
```

* Wait for "geonetwork-0" and "geonetwork-es-default-0" to be running : `kubectl -n geonetwork get pods -w`

```
NAME                      READY   STATUS    RESTARTS   AGE
geonetwork-0              1/1     Running   0          9m26s
geonetwork-es-default-0   0/1     Running   0          63s
```

* Open http://geonetwork.dev.localhost/geonetwork/




