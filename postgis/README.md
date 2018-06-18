
# postgis

## Description

Docker container running postgresql 10.4 with postgis 2.4

## Usage

* 1) Start postgis : `docker-compose up -d`

* 2) Configure environment (`~/.profile`)

```
export PGHOST=localhost
export PGUSER=postgis
export PGPASSWORD=postgis
```

* 3) Create gis database

```
createdb gis
psql -d gis -c "CREATE EXTENSION postgis"
```
