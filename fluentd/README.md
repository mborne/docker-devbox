# Fluentd

Container running [fluentd](https://www.fluentd.org/) to collect logs.

## Pre-requisite

* [OpenSearch](../opensearch/README.md) ( see [fluentd/conf/fluent.conf](fluentd/conf/fluent.conf) )

## Usage with docker-compose

```bash
docker-compose up -d
```

## Configure log driver

With `docker run` :

```bash
docker run --rm --log-driver=fluentd --log-opt tag="docker.echo.{{.ID}}" ubuntu echo '{"message":"hello world!"}'
```

Globaly adding the following properties in `/etc/docker/daemon.json` :

```json
{
    "log-driver": "fluentd",
    "log-opts": {
        "fluentd-address": "localhost:24224",
        "tag": "docker.{{.Name}}"
    }
}
```

## TODO

Find configure a parser like [fluent-plugin-parser-maybejson](https://github.com/ninadpage/fluent-plugin-parser-maybejson#fluent-plugin-parser-maybejson) supporting JSON or String for `log` entry.


## Reference

* [docs.fluentd.org - container-deployment/docker-compose](https://docs.fluentd.org/container-deployment/docker-compose)
* [www.fluentd.org - Docker Logging](https://www.fluentd.org/guides/recipes/docker-logging)
