# Fluentd

**WORK IN PROGRESS**

Container running [fluentd](https://www.fluentd.org/) to collect logs.

## Pre-requisite

* [OpenSearch](../opensearch/README.md) ( see [fluentd/conf/fluent.conf](fluentd/conf/fluent.conf) )

## Usage with docker

* Read [conf/fluent.conf](conf/fluent.conf)

* Start containers :

```bash
docker compose up -d
```

* To test with `docker run` :

```bash
docker run --rm --log-driver=fluentd --log-opt tag="docker.echo.{{.ID}}" ubuntu echo '{"message":"hello world!"}'
```

* To configure driver globally with `/etc/docker/daemon.json` :

```json
{
    "log-driver": "fluentd",
    "log-opts": {
        "fluentd-address": "localhost:24224",
        "tag": "docker.{{.Name}}.{{.ID}}"
    }
}
```

## Usage with Kubernetes

* Add repository : `helm repo add fluent https://fluent.github.io/helm-charts`
* Update helm repositories : `helm repo update`
* Create namespace : `kubectl create namespace fluent-system`
* Deploy fluent-bit :

```bash
helm -n fluent-system install -i fluent-bit fluent/fluent-bit
# or
helm -n fluent-system install -f fluent/helm/values-opensearch.yml fluent-bit fluent/fluent-bit
```

Note :

* see [fluent-bit/values.yaml](https://github.com/fluent/helm-charts/blob/main/charts/fluent-bit/values.yaml)

## Resources

* [docs.fluentd.org - container-deployment/docker-compose](https://docs.fluentd.org/container-deployment/docker-compose)
* [www.fluentd.org - Docker Logging](https://www.fluentd.org/guides/recipes/docker-logging)
