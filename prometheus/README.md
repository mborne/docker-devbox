# Prometheus

Containers running [Prometheus](https://prometheus.io/) and [Prometheus Blackbox Exporter](https://github.com/prometheus/blackbox_exporter?tab=readme-ov-file#blackbox-exporter).

## Usage with docker

* Start : `docker compose up -d`
* Open https://prometheus.dev.localhost


## Usage with Kubernetes

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
# To get portainer on https://portainer.dev.localhost
bash k8s-install.sh
# To get portainer on https://portainer.example.net
DEVBOX_HOSTNAME=example.net bash k8s-install.sh
```

* Read instructions :

> The Prometheus server can be accessed via port 80 on the following DNS name from within your cluster:
**prometheus-server.prometheus.svc.cluster.local**

> The Prometheus PushGateway can be accessed via port **9091** on the following DNS name from within your cluster:
**prometheus-prometheus-pushgateway.prometheus.svc.cluster.local**

> Get the PushGateway URL by running these commands in the same shell:
>
```bash
export POD_NAME=$(kubectl get pods --namespace prometheus -l "app=prometheus-pushgateway,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace prometheus port-forward $POD_NAME 9091
```


## Resources

About prometheus :

* [prometheus.io - docs - overview](https://prometheus.io/docs/introduction/overview/)
* [prometheus-community.github.io - Prometheus Community Kubernetes Helm Charts](https://prometheus-community.github.io/helm-charts/)

About prometheus blackbox exporter :

* [medium.com - Monitor Kubernets Services/Endpoints with Prometheus Blackbox Exporter](https://medium.com/@lambdaEranga/monitor-kubernets-services-endpoints-with-prometheus-blackbox-exporter-a64e062c05d5)





