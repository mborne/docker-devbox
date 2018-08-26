# postgis

## Description

Docker container running postgresql 10.4 with postgis 2.4

## Usage

* Start postgis : `docker-compose up -d`

* Configure environment (`~/.profile`)

```
export PGHOST=localhost
export PGUSER=postgis
export PGPASSWORD=postgis
```

* Create gis database

```
createdb gis
psql -d gis -c "CREATE EXTENSION postgis"
```
