# OpenSearch

Containers running [OpenSearch](https://opensearch.org/) for **DEV purpose**.

## URL

| Name                 | URL                                                    |
| -------------------- | ------------------------------------------------------ |
| OpenSearch           | https://os.dev.localhost/ <br /> http://localhost:9200 |
| OpenSearch Dashboard | https://os-dashboard.dev.localhost/                    |

## Usage with docker-compose

WARNING : Read [docker-compose.yml](docker-compose.yml) and note that security is disabled!

* Increase the value of `max_map_count` on Docker host :

```bash
sudo sysctl -w vm.max_map_count=262144
```

* Start containers :

```bash
docker compose up -d
```

* Open https://os-dashboard.dev.localhost/


## Ressources

* [opensearch.org - Install OpenSearch / Docker](https://opensearch.org/docs/latest/opensearch/install/docker/)



