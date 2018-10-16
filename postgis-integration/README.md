# postgis-integration

## Description

Helper script to load open datasets into postgis

see [mborne/postgis-integration](https://github.com/mborne/postgis-integration)

## Usage

* Create a "gis" database (see [postgis/README.md](../postgis/README.md))

* Import datasets

```bash
# init metadata.dataset table to trace loaded dataset
docker-compose run postgis-integration npm run postgis-init
docker-compose run postgis-integration npm run postgis-import naturalearth
docker-compose run postgis-integration npm run postgis-import adminexpress
# ...
```
