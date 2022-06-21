# geonetwork

Docker container running geonetwork (CSW, CSW-T)

## Usage

* Start geonetwork : `docker-compose up -d`

* Open http://geonetwork.localhost/geonetwork/

* Login with admin/admin

## Usage with kustomize

```bash
# https://geonetwork.localhost/geonetwork/
kubectl apply -k https://github.com/mborne/docker-devbox/geonetwork/manifest/base
```
