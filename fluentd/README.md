# Fluentd

Container running [fluentd](https://www.fluentd.org/) to collect logs.

## Pre-requisite

* [OpenSearch](../opensearch/README.md) ( see [fluentd/conf/fluent.conf](fluentd/conf/fluent.conf) )

## Usage with docker-compose

```bash
docker run --log-driver=fluentd --log-opt tag="docker.{{.ID}}" ubuntu echo "Hello Fluentd!"
```

## Reference

* [docs.fluentd.org - container-deployment/docker-compose](https://docs.fluentd.org/container-deployment/docker-compose)

