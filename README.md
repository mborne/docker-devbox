# docker-devstacks

Docker stacks to quickly setup a dev environment and test some tools.

## Stacks

### Reverse proxy

| Name                                                 | Description                                            |
| ---------------------------------------------------- | ------------------------------------------------------ |
| [traefik](traefik/README.md)                         | Provides `http://<service>.${HOST_HOSTNAME}` URLs      |
| [traefik-letsencrypt](traefik-letsencrypt/README.md) | Provides `https://<service>.${HOST_HOSTNAME}` URLs (1) |

### Spatial

| Name                                                 | Description                                       |
| ---------------------------------------------------- | ------------------------------------------------- |
| [postgis](postgis/README.md)                         | Store spatial data (tables with geometry columns) |
| [geoserver](geoserver/README.md)                     | Render spatial data (WMS, WFS, WMTS)              |
| [geonetwork](geonetwork/README.md) (CSW, CSW-T)      | Store metadata (CSW, CSW-T)                       |
| [postgis-integration](postgis-integration/README.md) | Load opendata datasets in postgis                 |

### Authentication

| Name                             | Description                                   |
| -------------------------------- | --------------------------------------------- |
| [openldap](openldap/README.md)   | LDAP server and admin UI                      |
| [keycloak](keycloak/README.md)   | SSO identity server (OAuth2)                  |

### Other

| Name                             | Description                                   |
| -------------------------------- | --------------------------------------------- |
| [gogs](gogs/README.md)           | GIT hosting                                   |
| [nexus](nexus/README.md)         | Artefact hosting (docker image, deb, rpm,...) |
| [jenkins](jenkins/README.md)     | Continous Integration                         |
| [ELK](elk/README.md)             | elasticsearch & kibana                        |
| [portainer](portainer/README.md) | Docker UI                                     |
| [sonarqube](sonarqube/README.md) | Code quality                                  |
| [owncloud](owncloud/README.md)   | File hosting                                  |
| [netcloud](netcloud/README.md)   | File hosting                                  |
| [rabbitmq](rabbitmq/README.md)   | Message Queue server                          |
| [whoami](netcloud/README.md)     | Trivial service to debug reverse proxy        |

## Usage

* 1) Create a network named `webgateway`

```bash
docker network create -d bridge --subnet=192.168.150.0/24 webgateway
```

* 2) Configure environment variables

| Name            | Description                                                                  | Default   |
| --------------- | ---------------------------------------------------------------------------- | --------- |
| `HOST_HOSTNAME` | Allows to change domain for LAN use throw traefik (registry.localhost, etc.) | localhost |


## License

[MIT](LICENSE)
