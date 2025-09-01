# fluent

Container running [fluent-bit](https://docs.fluentbit.io/manual/installation/docker) to parse and send logs to [OpenSearch](../opensearch/README.md).

## Usage with docker

* Read [docker-compose.yaml](docker-compose.yaml) and [config/fluent-bit.conf](config/fluent-bit.conf)
* Ensure that [openseach](../opensearch/README.md) is running
* Start fluent-bit : `docker compose up -d`
* [Configure logging driver](https://docs.docker.com/config/containers/logging/configure/) to use either **journald or fluentd driver**

```bash
# journald for a given container
docker run --log-driver=journald --rm --name test_fluent -t ubuntu echo "Testing a raw log message"
docker run --log-driver=journald --rm --name test_fluent -t ubuntu echo '{"content":"Testing a JSON log message","label":"meuh"}'
docker run --log-driver=journald --rm --name test_fluent -t ubuntu echo '{"content":"Testing a JSON \r\n multiple line \r\n log message","label":"meuh"}'

# fluentd for a given container
docker run --log-driver=fluentd --rm --name test_fluent -t ubuntu echo '{"content":"Testing a JSON log message","label":"meuh"}'
```

* Note that **you may also configure globally docker to log using journald** in `/etc/docker/daemon.json` :

```json
{
    "log-driver": "journald"
}
```

(`systemctl daemon-reload && systemctl restart docker`)

## Usage with Kubernetes

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
bash k8s-install.sh
```

## Ressources

* [github.com - fluent/helm-charts - Fluent Helm Charts](https://github.com/fluent/helm-charts#readme)
* [logz.io - Fluentd vs. Fluent Bit: Side by Side Comparison](https://logz.io/blog/fluentd-vs-fluent-bit/)
* See also [Loki](../loki/README.md)
