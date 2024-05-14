# Prometheus

Containers running [Prometheus](https://prometheus.io/) and [Prometheus Blackbox Exporter](https://github.com/prometheus/blackbox_exporter?tab=readme-ov-file#blackbox-exporter).

## Usage with docker

> See [config/prometheus.yml](config/prometheus.yml) and [config/blackbox-exporter.yml](config/blackbox-exporter.yml)

* Start : `docker compose up -d`
* Open https://prometheus.dev.localhost

## Usage with Kubernetes

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
# To get prometheus on https://prometheus.dev.localhost
bash k8s-install.sh
# To get prometheus on https://prometheus.example.net
DEVBOX_HOSTNAME=example.net bash k8s-install.sh
```

* Open https://prometheus.dev.localhost and https://blackbox-exporter.dev.localhost


## Resources

About prometheus :


* [prometheus.io - docs - overview](https://prometheus.io/docs/introduction/overview/)
* [prometheus-community.github.io - Prometheus Community Kubernetes Helm Charts](https://prometheus-community.github.io/helm-charts/)

About prometheus-blackbox-exporter :

* [medium.com - Monitor Kubernets Services/Endpoints with Prometheus Blackbox Exporter](https://medium.com/@lambdaEranga/monitor-kubernets-services-endpoints-with-prometheus-blackbox-exporter-a64e062c05d5)





