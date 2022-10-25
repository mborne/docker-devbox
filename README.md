# mborne/docker-devbox

This repository provides stacks to setup a **local dev environment** with [docker compose](docs/docker-compose.md) or [Kubernetes](docs/kubernetes.md) for some of them.

## Usage

Get started running [traefik](traefik/README.md) and [whoami](whoami/README.md) which provides a simple example to understand traefik.

See [notes about docker-compose](docs/docker-compose.md) for more details.

## Stacks

### Load balancer

* [traefik](traefik/README.md)
* [whoami](whoami/README.md)

### GUI

* [kibana](kibana/README.md)
* [adminer](adminer/README.md)

### Databases

* [OpenSearch](opensearch/README.md)
* [Elasticsearch](elasticsearch/README.md)
* [postgis](postgis/README.md)

### Storage

* [nexus](nexus/README.md)
* [nextcloud](nextcloud/README.md)
* [longhorn](longhorn/README.md)

### Spatial services

* [geoserver (WMS, WFS, WMTS)](geoserver/README.md) 
* [geonetwork (CSW, CSW-T)](geonetwork/README.md) 

### CI/CD

* [argocd](argocd/README.md)
* [jenkins](jenkins/README.md)
* [sonarqube](sonarqube/README.md)

### CMS

* [wordpress](wordpress/README.md)
* [drupal](drupal/README.md)

### Authentication

* [keycloak](keycloak/README.md)
* [openldap](openldap/README.md)

### Secrets

* [vault](vault/README.md)

### Mailing

* [mailhog](mailhog/README.md)
* [mailer](mailer/README.md)

### Monitoring

* [matomo](matomo/README.md)
* [netdata](netdata/README.md)

### Messaging

* [rabbitmq](rabbitmq/README.md)

## License

[MIT](LICENSE)
