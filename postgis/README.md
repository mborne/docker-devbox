# PostGIS

Container running [PostgreSQL with the spatial extension PostGIS](https://registry.hub.docker.com/r/postgis/postgis/).

## Usage with docker

* Start postgis :

```bash
export POSTGRES_USER=postgis
export POSTGRES_PASSWORD=ChangeIt
docker compose up -d
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

## Usage with Kubernetes

See [CloudNativePG](../cnpg/README.md) which provides a sample PostGIS cluster.

## See also

To tune PostgreSQL :

* [pgtune.leopard.in.ua](http://pgtune.leopard.in.ua/)
* [urator.cybertec.at](http://pgconfigurator.cybertec.at/)
* [github.com - esgn/pgtuned](https://github.com/esgn/pgtuned#pgtuned--)
