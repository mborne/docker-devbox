# OpenSearch

## Usage with docker-compose

* Increase the value of `max_map_count` on Docker host :

```bash
sudo sysctl -w vm.max_map_count=262144
```

* Start containers :

```bash
docker compose up -d
```

* Open https://os-dashboard.dev.localhost/ and login with admin/admin


## Ressources

* https://opensearch.org/docs/latest/opensearch/install/docker/



