# mborne/docker-devbox

This repository provides a framework to setup a local dev environment with docker :

* [docker-compose](https://docs.docker.com/compose/) is used to define and start each service (ex : [kibana/docker-compose.yml](kibana/docker-compose.yml))
* [traefik](https://hub.docker.com/_/traefik) provides nice URL for web services (ex : http://kibana.localhost)
* [dnsmasq](dnsmasq/README.md) allows container IP resolution from host (ex : `openldap.devbox`, `mailhog.devbox`, `postgis.devbox`, etc.) and avoid port exposure while coding new services
* Containers run on the same network named `devbox` (`192.168.150.0/24`) to simplify communication between containers/stacks
* Named volumes allows data persistence to ease the purge of running services

It also provides a set of sample stacks (usual dependencies for my projects, sandbox, experiments, etc.)

## Usage

> Note that a [start.sh](start.sh) script is under development to performs this steps with some checks

* 1) Create a network named `devbox`

```bash
docker network create -d bridge \
    --gateway 192.168.150.1 \
    --ip-range 192.168.150.128/25 \
    --subnet 192.168.150.0/24 \
    devbox
```

* 2) Start [dnsmasq](dnsmasq/README.md) and add `192.168.150.1` as DNS server on host

> optional, to resolve `*.devbox` IP's from host

```bash
cd dnsmasq
docker-compose up -d
# configure your system to add 192.168.150.2 as a DNS server...
```

* 3) Run [traefik](traefik/README.md) ([whoami](whoami/README.md) provide a simple example to understand traefik)


## Stacks

### Core services

| Name                         | Description                                                                                          |
| ---------------------------- | ---------------------------------------------------------------------------------------------------- |
| [traefik](traefik/README.md) | Reverse proxy providing `http://<service>.${HOST_HOSTNAME}` URLs according to labels                 |
| [dnsmasq](dnsmasq/README.md) | DNS server (`*.localhost` -> `127.0.0.1`, `*.devbox` -> container IP, `other` -> external DNS server |
| [whoami](whoami/README.md)   | Trivial service to test and understand traefik                                                       |

## ELK

| Name                                     | Description             |
| ---------------------------------------- | ----------------------- |
| [elasticsearch](elasticsearch/README.md) | elasticsearch (2 nodes) |
| [kibana](kibana/README.md)               | kibana                  |

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

### Storage

| Name                             | Description                                   |
| -------------------------------- | --------------------------------------------- |
| [gogs](gogs/README.md)           | GIT hosting                                   |
| [nexus](nexus/README.md)         | Artefact hosting (docker image, deb, rpm,...) |
| [owncloud](owncloud/README.md)   | File hosting                                  |
| [nextcloud](nextcloud/README.md) | File hosting                                  |

### Continuous integration

| Name                             | Description           |
| -------------------------------- | --------------------- |
| [jenkins](jenkins/README.md)     | Continous Integration |
| [sonarqube](sonarqube/README.md) | Code quality          |

### Various

| Name                           | Description                        |
| ------------------------------ | ---------------------------------- |
| [mailhog](mailhog/README.md)   | Web and API based SMTP test server |
| [rabbitmq](rabbitmq/README.md) | Message broker                     |

## License

[MIT](LICENSE)
