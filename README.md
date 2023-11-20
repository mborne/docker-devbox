# mborne/docker-devbox

Provides stacks to setup a **container-based development environment** with [Docker](docs/docker.md) or [Kubernetes](docs/kubernetes.md) for some of them.

## Motivation

This is my playground to learn and illustrate how to deploy application with [docker compose](https://docs.docker.com/compose/), [Kustomize](https://kustomize.io/) (`kubectl apply -k`) and [helm](https://helm.sh/).

## Getting started

[Usage with docker](docs/docker.md) :

* [Install docker compose plugin](https://docs.docker.com/compose/install/linux/)
* Create devbox's network : `docker network create devbox`
* Try some stacks, for example :
  * [redis](redis/README.md)
  * [traefik](traefik/README.md) to get `https://whoami.dev.localhost` instead of `http://localhost:8888`
  * [portainer](portainer/README.md) to get a web based UI for docker
  * ...

[Usage with Kubernetes](docs/kubernetes.md) :

* Install [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) and [helm](https://helm.sh/docs/intro/install/)
* Configure kubectl to use a [DEV instance](docs/kubernetes-dev.md)


## Stacks

### Load balancer and reverse proxy

| Name                                                           | Description                                                                       | Docker  |   K8S   |
| -------------------------------------------------------------- | --------------------------------------------------------------------------------- | :-----: | :-----: |
| [traefik](traefik/README.md)                                   | A reverse proxy including **configuration discovery** mechanism                   | &#9745; | &#9745; |
| [nginx-ingress-controller](nginx-ingress-controller/README.md) | A common alternative to [Traefik](traefik/README.md) for Kubernetes               |   NA    | &#9745; |
| [whoami](whoami/README.md)                                     | An helloworld to test/discover load balancers                                     | &#9745; | &#9745; |
| [cert-manager](cert-manager/README.md)                         | An helper to generate TLS certificates from various issuers including LetsEncrypt |   NA    | &#9745; |

### Container UI

| Name                                                   | Description                                          | Docker  |   K8S   |
| ------------------------------------------------------ | ---------------------------------------------------- | :-----: | :-----: |
| [kubernetes-dashboard](kubernetes-dashboard/README.md) | Web-based UI for Kubernetes clusters                 | &#9745; | &#9745; |
| [portainer](portainer/README.md)                       | Web-based UI for Kubernetes, Docker, Swarm and Nomad | &#9745; | &#9745; |

### CI/CD pipeline

| Name                             | Description                                                                 | Docker  |   K8S   |
| -------------------------------- | --------------------------------------------------------------------------- | :-----: | :-----: |
| [Jenkins](jenkins/README.md)     | Open source automation server with hundred of plugins (ansible, jmeter,...) | &#9745; | &#9745; |
| [ArgoCD](argocd/README.md)       | GitOps **continuous delivery** tool for **Kubernetes**                      |   NA    | &#9745; |
| [SonarQube](sonarqube/README.md) | Centralisation of Code Quality and Code Security metrics                    | &#9745; | &#9744; |
| [Vault](vault/README.md)         | Secret storage and management server with an API                            | &#9745; | &#9744; |

### Authentication

| Name                           | Description                                                           | Docker  |   K8S   |
| ------------------------------ | --------------------------------------------------------------------- | :-----: | :-----: |
| [Keycloak](keycloak/README.md) | Open Source Identity and Access Management providing (**OIDC, SAML**) | &#9745; | &#9744; |
| [OpenLDAP](openldap/README.md) | Community developed **LDAP** software                                 | &#9745; | &#9744; |

### Storage

| Name                             | Description                                                                                             | Docker  |                             K8S                              |
| -------------------------------- | ------------------------------------------------------------------------------------------------------- | :-----: | :----------------------------------------------------------: |
| [MinIO](minio/README.md)         | **Object storage** with an **S3** compatible API                                                        | &#9745; | [&#9744;](https://github.com/mborne/docker-devbox/issues/25) |
| [Nextcloud](nextcloud/README.md) | Open collaborative platform (file storage, talk, calendar,...)                                          | &#9745; |                           &#9744;                            |
| [Nexus](nexus/README.md)         | [Nexus Repository Manager](https://help.sonatype.com/repomanager3) to manage binaries & build artifacts | &#9745; |                           &#9744;                            |

### ReadWriteMany

| Name                                                                         | Description                                                                                         | Docker  |   K8S   |
| ---------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | :-----: | :-----: |
| [Longhorn](longhorn/README.md)                                               | **Distributed block storage** for Kubernetes providing `ReadWriteMany` volumes                      |   NA    | &#9745; |
| [nfs-server-provisioner](nfs-server-provisioner/README.md)                   | Deploy a NFS server to provide `ReadWriteMany` volumes                                              |   NA    | &#9745; |
| [nfs-subdir-external-provisioner](nfs-subdir-external-provisioner/README.md) | Use existing NFS server to provide `ReadWriteMany` volumes                                          |   NA    | &#9745; |
| [nfs-server](nfs-server/README.md)                                           | **NFS server** to test [nfs-subdir-external-provisioner](nfs-subdir-external-provisioner/README.md) | &#9745; | &#9745; |

### Database

| Name                                 | Description                                                                                          | Docker  |   K8S   |
| ------------------------------------ | ---------------------------------------------------------------------------------------------------- | :-----: | :-----: |
| [PostGIS](postgis/README.md)         | [PostgreSQL](https://www.postgresql.org/) with the spatial extension [PostGIS](https://postgis.net/) | &#9745; | &#9745; |
| [CloudBeaver](cloudbeaver/README.md) | Server side version of [DBeaver](https://dbeaver.io/)                                                | &#9745; | &#9744; |
| [adminer](adminer/README.md)         | Database management in a single PHP file                                                             | &#9745; | &#9745; |
| [Redis](redis/README.md)             | [Redis](https://redis.io/) key-value database                                                        | &#9745; | &#9744; |


### Logs and monitoring

| Name                                     | Description                                                                  | Docker  |   K8S   |
| ---------------------------------------- | ---------------------------------------------------------------------------- | :-----: | :-----: |
| [Grafana](grafana/README.md)             | Grafana with Loki and Prometheus datasources                                 | &#9745; | &#9745; |
| [Prometheus](prometheus/README.md)       | Grafana/Prometheus for system and monitoring                                 | &#9745; | &#9745; |
| [Loki](loki/README.md)                   | Grafana/Loki with promtail to index logs                                     | &#9745; | &#9745; |
| [Kibana](kibana/README.md)               | ELK - User Interface                                                         | &#9745; | &#9744; |
| [OpenSearch](opensearch/README.md)       | Forked from [Elasticsearch](https://www.elastic.co/fr/elasticsearch/) by AWS | &#9745; | &#9745; |
| [Elasticsearch](elasticsearch/README.md) | ELK - Log storage and indexation                                             | &#9745; | &#9745; |
| [Netdata](netdata/README.md)             | A monitoring tool with an easy setup                                         | &#9745; | &#9744; |

### GeoSpatial services

| Name                               | Description                                                                                                                        | Docker  |   K8S   |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | :-----: | :-----: |
| [GeoServer](geoserver/README.md)   | Open source server for sharing **geospatial data** with [OGC](https://www.ogc.org/) compliant protocols (**WMS, WMTS, WFS**)       | &#9745; | &#9745; |
| [Geonetwork](geonetwork/README.md) | Catalog application to manage spatially referenced resources with [OGC](https://www.ogc.org/) compliant protocols (**CSW, CSW-T**) | &#9745; | &#9745; |

### Mailing

| Name                         | Description                                                                                                         | Docker  |   K8S   |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------- | :-----: | :-----: |
| [MailHog](mailhog/README.md) | SMTP testing server providing with an API to retrieve emails                                                        | &#9745; | &#9744; |
| [mailer](mailer/README.md)   | SMTP relay based on [namshi/smtp](https://hub.docker.com/r/namshi/smtp) image to send emails using a google account | &#9745; | &#9744; |

### Miscellaneous

| Name                             | Description                                            | Docker  |   K8S   |
| -------------------------------- | ------------------------------------------------------ | :-----: | :-----: |
| [Wordpress](wordpress/README.md) | The famous [WordPress](https://wordpress.com/) **CMS** | &#9745; | &#9744; |
| [Matomo](matomo/README.md)       | "Google Analytics alternative"                         | &#9745; | &#9744; |

## License

[MIT](LICENSE)
