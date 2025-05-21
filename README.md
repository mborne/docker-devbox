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

* [traefik](traefik/README.md) : A reverse proxy including **configuration discovery** mechanism.
* [nginx-ingress-controller](nginx-ingress-controller/README.md) : A common alternative to [Traefik](traefik/README.md) (**K8S only**).
* [whoami](whoami/README.md) : An helloworld app to test [traefik](traefik/README.md) or [nginx-ingress-controller](nginx-ingress-controller/README.md).
* [cert-manager](cert-manager/README.md) :  An helper to generate TLS certificates from various issuers including LetsEncrypt (**K8S only**)

### Container UI

* [kubernetes-dashboard](kubernetes-dashboard/README.md) : Web-based UI for Kubernetes.
* [portainer](portainer/README.md) : Web-based UI for Kubernetes, Docker, Swarm and Nomad.

### LLM

* [ollama](ollama/README.md) : [Ollama API](https://github.com/likelovewant/ollama-for-amd/blob/main/docs/api.md) to use locally [open LLM models](https://ollama.com/search).
* [open-webui](open-webui/README.md) : Web-based UI (ChatGPT-like) for [Ollama](ollama/README.md).

### CI/CD pipeline

* [ArgoCD](argocd/README.md) : GitOps **continuous delivery** tool for **Kubernetes**.
* [Jenkins](jenkins/README.md) : Open source automation server with hundred of plugins (ansible, jmeter,...).

### Data pipeline orchestration

> See also [www.zenml.io - Orchestration Showdown: Dagster vs Prefect vs Airflow](https://www.zenml.io/blog/orchestration-showdown-dagster-vs-prefect-vs-airflow)

* [prefect](prefect/README.md) (docker only for now)

### Authentication

> See also [dex](https://github.com/dexidp/dex#readme) and [oauth2-proxy](https://oauth2-proxy.github.io/oauth2-proxy/)

* [Keycloak](keycloak/README.md) : Open Source Identity and Access Management providing **OIDC and SAML** implementation (**K8S not implemented**)

### Storage

* [MinIO](minio/README.md) : **Object storage** with an **S3** compatible API.
* [Longhorn](longhorn/README.md) : **Distributed block storage for K8S** providing `ReadWriteMany` volumes (K8S only)
* [restic-server](restic-server/README.md) : [Rest Server](https://github.com/restic/rest-server#readme) to **push [restic](https://restic.net/) backups over HTTPS** (warning : incomplete and not well documented)
* [nfs-subdir-external-provisioner](nfs-subdir-external-provisioner/README.md) : Provides `ReadWriteMany` volumes using existing NFS server.
    * [nfs-demo](nfs-demo/README.md) : Illustrates the use of a "nfs" storage class providing `ReadWriteMany` support.
    * [nfs-server](nfs-server/README.md) : **NFS server** to test [nfs-subdir-external-provisioner](nfs-subdir-external-provisioner/README.md).
 
### Database

* [PostGIS](postgis/README.md) : [PostgreSQL](https://www.postgresql.org/) with the spatial extension [PostGIS](https://postgis.net/).
* [Redis](redis/README.md)
* [CloudBeaver](cloudbeaver/README.md) : Web-based UI for SQL databases (**docker only**)

### Logging and monitoring

Option 1 :

* [Grafana](grafana/README.md) : Grafana with Loki and Prometheus datasources and dashboards preconfigured.
* [Prometheus](prometheus/README.md) : Grafana/**Prometheus** for system and monitoring.
* [Loki](loki/README.md) : Grafana/**Loki** to store logs with Grafana/**Promtail** to ship logs.
* [x509-certificate-exporter](x509-certificate-exporter/README.md) : Prometheus exportor to monitor TLS certicates (**K8S only**)

Option 2 (variant of the famous ELK stack) :

* [OpenSearch](opensearch/README.md) : [OpenSearch and OpenSearch Dashboards](https://docs.opensearch.org/docs/latest/about/) (fork from [ElasticSearch](https://www.elastic.co/fr/elasticsearch/) and [Kibana](https://www.elastic.co/fr/kibana) by AWS).
* [fluent](fluent/README.md) : [fluent-bit](https://docs.fluentbit.io/manual) sending containers and systemd logs to [OpenSearch](opensearch/README.md).

### Security

* [kyverno](kyverno/README.md) : [kyverno](https://artifacthub.io/packages/helm/kyverno/kyverno) with [kyverno-policies](https://artifacthub.io/packages/helm/kyverno/kyverno-policies) and [Policy Reporter](https://kyverno.github.io/policy-reporter/) (metrics & UI).
* [trivy](trivy/README.md) : [trivy-operator from Aqua Security](https://github.com/aquasecurity/trivy-operator#readme) (K8S only)
* [SonarQube](sonarqube/README.md) : Centralisation of Code Quality and Code Security metrics.

### GeoSpatial services

* [GeoServer](geoserver/README.md) : Open source server for sharing **geospatial data** with [OGC](https://www.ogc.org/) compliant protocols (WMS, WMTS, WFS) (**docker only**)

### Mailing

* [MailHog](mailhog/README.md) : **SMTP testing server** providing with an API to retrieve emails (docker only)
* [mailer](mailer/README.md) : SMTP relay based on [namshi/smtp](https://hub.docker.com/r/namshi/smtp) image to **send emails using a google account** (docker only)

### Miscellaneous

* [Wordpress](wordpress/README.md) (docker only)
* [Matomo](matomo/README.md) : "Google Analytics alternative" (docker only)

## License

[MIT](LICENSE)
