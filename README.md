# docker-devstacks

## Description

Docker stacks for **local and dev use only** .

## Create webgateway network

```
docker network create -d bridge --subnet=192.168.100.0/24 webgateway
```

## Stacks

* [postgis](postgis/README.md)
* [ELK](elk/README.md)
* [geoserver](geoserver/README.md)
