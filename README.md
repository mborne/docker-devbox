# mborne/docker-devbox

Provides stacks to setup a **container-based development environment** with [docker compose](docs/docker-compose.md) or [Kubernetes](docs/kubernetes.md) for some of them.

## Motivation

This is my playground to learn and illustrate how to deploy application with [docker compose](https://docs.docker.com/compose/), [Kustomize](https://kustomize.io/) (`kubectl apply -k`) and [helm](https://helm.sh/).

## Usage

Get started running [traefik](traefik/README.md) and [whoami](whoami/README.md) which provides a simple example to understand [how traefik works](https://doc.traefik.io/traefik/).

See [notes about docker-compose](docs/docker-compose.md) for more details.

## Stacks

| Name                                     | Description                                                                                                                        | Docker  |                             K8S                              |
| ---------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | :-----: | :----------------------------------------------------------: |
| [traefik](traefik/README.md)             | A reverse proxy/load balancer including **configuration discovery** mechanism                                                      | &#9745; |                           &#9745;                            |
| [whoami](whoami/README.md)               | An helloworld to discover [traefik](traefik/README.md)                                                                             | &#9745; |                           &#9745;                            |
| [ArgoCD](argocd/README.md)               | GitOps **continuous delivery** tool for **Kubernetes**                                                                             |   NA    |                           &#9745;                            |
| [Vault](vault/README.md)                 | Secret storage and management server with an API                                                                                   | &#9745; |                           &#9744;                            |
| [Keycloak](keycloak/README.md)           | Open Source Identity and Access Management providing (**OIDC, SAML**)                                                              | &#9745; |                           &#9744;                            |
| [OpenLDAP](openldap/README.md)           | Community developed **LDAP** software                                                                                              | &#9745; |                           &#9744;                            |
| [Longhorn](longhorn/README.md)           | **Distributed block storage** for Kubernetes providing `ReadWriteMany` volumes                                                     |   NA    |                           &#9745;                            |
| [PostGIS](postgis/README.md)             | [PostgreSQL](https://www.postgresql.org/) with the spatial extension [PostGIS](https://postgis.net/)                               | &#9745; |                           &#9745;                            |
| [MinIO](minio/README.md)                 | **Object storage** with an **S3** compatible API                                                                                   | &#9745; | [&#9744;](https://github.com/mborne/docker-devbox/issues/25) |
| [Elasticsearch](elasticsearch/README.md) | ELK - Log storage and indexation                                                                                                   | &#9745; |                           &#9745;                            |
| [Kibana](kibana/README.md)               | ELK - User Interface                                                                                                               | &#9745; |                           &#9745;                            |
| [OpenSearch](opensearch/README.md)       | Forked from [Elasticsearch](https://www.elastic.co/fr/elasticsearch/) by AWS                                                       | &#9745; |                           &#9745;                            |
| [Nexus](nexus/README.md)                 | [Nexus Repository Manager](https://help.sonatype.com/repomanager3) to manage binaries & build artifacts                            | &#9745; |                           &#9744;                            |
| [Nextcloud](nextcloud/README.md)         | Open collaborative platform (file storage, talk, calendar,...)                                                                     | &#9745; |                           &#9744;                            |
| [adminer](adminer/README.md)             | Database management in a single PHP file                                                                                           | &#9745; |                           &#9745;                            |
| [GeoServer](geoserver/README.md)         | Open source server for sharing **geospatial data** with [OGC](https://www.ogc.org/) compliant protocols (**WMS, WMTS, WFS**)       | &#9745; |                           &#9745;                            |
| [Geonetwork](geonetwork/README.md)       | Catalog application to manage spatially referenced resources with [OGC](https://www.ogc.org/) compliant protocols (**CSW, CSW-T**) | &#9745; |                           &#9745;                            |
| [Jenkins](jenkins/README.md)             | Open source automation server with hundred of plugins (ansible, jmeter,...)                                                        | &#9745; |                           &#9745;                            |
| [SonarQube](sonarqube/README.md)         | Centralisation of Code Quality and Code Security metrics                                                                           | &#9745; |                           &#9744;                            |
| [Wordpress](wordpress/README.md)         | The famous [WordPress](https://wordpress.com/) **CMS**                                                                             | &#9745; |                           &#9744;                            |
| [MailHog](mailhog/README.md)             | SMTP testing server providing with an API to retrieve emails                                                                       | &#9745; |                           &#9744;                            |
| [mailer](mailer/README.md)               | SMTP relay based on [namshi/smtp](https://hub.docker.com/r/namshi/smtp) image to send emails using a google account                | &#9745; |                           &#9744;                            |
| [Matomo](matomo/README.md)               | "Google Analytics alternative"                                                                                                     | &#9745; |                           &#9744;                            |
| [Netdata](netdata/README.md)             | A monitoring tool with an easy setup                                                                                               | &#9745; |                           &#9744;                            |

## License

[MIT](LICENSE)
