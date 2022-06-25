# postgis

Container running [postgis](https://registry.hub.docker.com/r/postgis/postgis/).

## Usage with docker-compose

* Start postgis :

```bash
export POSTGRES_USER=postgis
export POSTGRES_PASSWORD=ChangeIt
docker-compose up -d
```

* Configure psql (`~/.profile`) :

```bash
export PGHOST=localhost
export PGUSER=postgis
export PGPASSWORD=ChangeIt
```

* Create gis database

```bash
createdb gis
psql -d gis -c "CREATE EXTENSION postgis"
```

## Usage with kustomize

**TODO**

Testing :

```bash
# forward port to pod
kubectl -n postgis port-forward --address 0.0.0.0 pod/postgis-0 5432:5432
# test
psql -h localhost -U postgis -l
```

## Warning with kustomize

This is an experiment where local storage is used by default and adapted to a **single cluster node**. `/var/devbox/postgis-13` is created on a random node (see `kubectl -n postgis get pods -o wide`).

## Ressources

Tuning :

* [pgtune.leopard.in.ua](http://pgtune.leopard.in.ua/)
* [urator.cybertec.at](http://pgconfigurator.cybertec.at/)
