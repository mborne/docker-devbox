# mborne/docker-devbox

This repository provides a framework to setup a **local dev environment** with docker.

## Key points

* [docker-compose](https://docs.docker.com/compose/) is used to define and start each service (ex : [kibana/docker-compose.yml](kibana/docker-compose.yml))
* [traefik](https://hub.docker.com/_/traefik) provides nice URL for web services (ex : http://kibana.localhost)
* Containers run on the same network named `devbox` (`192.168.150.0/24`) to simplify communication between containers/stacks
* Named volumes allows data persistence to ease the purge of running services

It also provides a set of sample stacks (usual dependencies for my projects, sandbox, experiments, etc.)

## Schema

![Architecture schema](docs/devbox.png)

## Usage

> Note that a [start.sh](start.sh) performs most of this steps with some checks

* Create a network named `devbox`

```bash
docker network create -d bridge \
    --gateway 192.168.150.1 \
    --ip-range 192.168.150.128/25 \
    --subnet 192.168.150.0/24 \
    devbox
```

* Run [traefik](traefik/README.md) ([whoami](whoami/README.md) provide a simple example to understand traefik)


## Stacks

### Core services

| Name                             | Description                                                                                 |
|----------------------------------|---------------------------------------------------------------------------------------------|
| [traefik](traefik/README.md)     | Reverse proxy providing URLs according to labels (ex : `http://<service>.${HOST_HOSTNAME}`) |
| [whoami](whoami/README.md)       | Trivial service to test and understand traefik                                              |
| [portainer](portainer/README.md) | Docker web UI                                                                               |

## ELK

| Name                                     | Description             |
|------------------------------------------|-------------------------|
| [elasticsearch](elasticsearch/README.md) | elasticsearch (2 nodes) |
| [kibana](kibana/README.md)               | kibana                  |

### Spatial

| Name                                                 | Description                                       |
|------------------------------------------------------|---------------------------------------------------|
| [postgis](postgis/README.md)                         | Store spatial data (tables with geometry columns) |
| [geoserver](geoserver/README.md)                     | Render spatial data (WMS, WFS, WMTS)              |
| [geonetwork](geonetwork/README.md) (CSW, CSW-T)      | Store metadata (CSW, CSW-T)                       |
| [postgis-integration](postgis-integration/README.md) | Load opendata datasets in postgis                 |

### Authentication

| Name                           | Description                  |
|--------------------------------|------------------------------|
| [openldap](openldap/README.md) | LDAP server and admin UI     |
| [keycloak](keycloak/README.md) | SSO identity server (OAuth2) |

### Storage

| Name                             | Description                                   |
|----------------------------------|-----------------------------------------------|
| [gogs](gogs/README.md)           | GIT hosting                                   |
| [nexus](nexus/README.md)         | Artefact hosting (docker image, deb, rpm,...) |
| [owncloud](owncloud/README.md)   | File hosting                                  |
| [nextcloud](nextcloud/README.md) | File hosting                                  |

### Continuous integration

| Name                             | Description           |
|----------------------------------|-----------------------|
| [jenkins](jenkins/README.md)     | Continous Integration |
| [sonarqube](sonarqube/README.md) | Code quality          |

### Various

| Name                           | Description                        |
|--------------------------------|------------------------------------|
| [mailhog](mailhog/README.md)   | Web and API based SMTP test server |
| [rabbitmq](rabbitmq/README.md) | Message broker                     |
| [drupal](drupal/README.md)     | CMS                                |

## License

[MIT](LICENSE)
