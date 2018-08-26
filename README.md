# docker-devstacks

## Description

Docker stacks for **local and dev use only**.

## Create webgateway network

```bash
docker network create -d bridge --subnet=192.168.100.0/24 webgateway
```

## Environment variables

| Name          | Description                                                     | Default   |
|---------------|-----------------------------------------------------------------|-----------|
| HOST_HOSTNAME | Allows to change domain for LAN use (registry.localhost, etc.)  | localhost |

## Stacks

### Core services

* [traefik](traefik/README.md)
* [nexus](nexus/README.md)
* [ELK](elk/README.md)

### Docker management

* [portainer](portainer/README.md)

### CI

* [jenkins](jenkins/README.md)

### Spatial

* [postgis](postgis/README.md)
* [geoserver](geoserver/README.md)

## License

[MIT](LICENSE)
