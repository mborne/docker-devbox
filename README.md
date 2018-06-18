# docker-devstacks

## Description

Docker stacks for local and dev use.

## Create webgateway network

```
docker network create -d bridge --subnet=192.168.100.0/24 webgateway
```

## Start stacks

* [postgis](postgis/README.md)
* [ELK](elk/README.md)
