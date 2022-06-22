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

## Tuning

See :

* [pgtune.leopard.in.ua](http://pgtune.leopard.in.ua/)
* [urator.cybertec.at](http://pgconfigurator.cybertec.at/)
