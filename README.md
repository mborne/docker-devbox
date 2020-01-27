# docker-devbox

A set of conventions and stacks to setup a local dev environment with docker.

## Goals

* Start, stop, rebuild and upgrade services without losing data
* Access web services from host throw nice URL (http://kibana.localhost for example)
* Access other services from host (SMTP) throw nice hostnames (mailhog.devbox)

## How it works?

* `docker-compose` is used to define and start each service (`{service-name}/docker-compose.yml`)
* Data are persisted in named volumes
* All containers runs on the same network : `devbox` (`192.168.150.0/24`)
* `traefik` container exposes URL according to container labels
* `dnsmasq` is running in a container with a static IP `192.168.150.2` to :

  * Resolve `*.localhost` as `127.0.0.1` and to use `192.168.150.2`
  * Forward container name resolution to the [docker embedded DNS server](https://docs.docker.com/v17.09/engine/userguide/networking/configure-dns/) (`127.0.0.11`)

## Usage

* Create a network named `devbox`

```bash
docker network create -d bridge \
    --gateway 192.168.150.1 \
    --ip-range 192.168.150.128/25 \
    --subnet 192.168.150.0/24 \
    devbox
```

* Configure environment variables

| Name            | Description                                                                  | Default   |
| --------------- | ---------------------------------------------------------------------------- | --------- |
| `HOST_HOSTNAME` | Allows to change domain for LAN use throw traefik (registry.localhost, etc.) | localhost |

* Run services


## Stacks

### Core services

| Name                         | Description                                                                          |
| ---------------------------- | ------------------------------------------------------------------------------------ |
| [traefik](traefik/README.md) | Reverse proxy providing `http://<service>.${HOST_HOSTNAME}` URLs according to labels |

### Spatial

| Name                                                 | Description                                       |
| ---------------------------------------------------- | ------------------------------------------------- |
| [postgis](postgis/README.md)                         | Store spatial data (tables with geometry columns) |
| [geoserver](geoserver/README.md)                     | Render spatial data (WMS, WFS, WMTS)              |
| [geonetwork](geonetwork/README.md) (CSW, CSW-T)      | Store metadata (CSW, CSW-T)                       |
| [postgis-integration](postgis-integration/README.md) | Load opendata datasets in postgis                 |

### Authentication

| Name                           | Description                  |
| ------------------------------ | ---------------------------- |
| [openldap](openldap/README.md) | LDAP server and admin UI     |
| [keycloak](keycloak/README.md) | SSO identity server (OAuth2) |

## ELK

| Name                                     | Description             |
| ---------------------------------------- | ----------------------- |
| [elasticsearch](elasticsearch/README.md) | elasticsearch (2 nodes) |
| [kibana](kibana/README.md)               | kibana                  |
| [logstash](logstash/README.md)           | logstash with heartbeat |

### Other

| Name                             | Description                                   |
| -------------------------------- | --------------------------------------------- |
| [gogs](gogs/README.md)           | GIT hosting                                   |
| [nexus](nexus/README.md)         | Artefact hosting (docker image, deb, rpm,...) |
| [jenkins](jenkins/README.md)     | Continous Integration                         |
| [portainer](portainer/README.md) | Docker UI                                     |
| [sonarqube](sonarqube/README.md) | Code quality                                  |
| [owncloud](owncloud/README.md)   | File hosting                                  |
| [netcloud](netcloud/README.md)   | File hosting                                  |
| [rabbitmq](rabbitmq/README.md)   | Message Queue server                          |
| [whoami](netcloud/README.md)     | Trivial service to debug reverse proxy        |

## License

[MIT](LICENSE)
