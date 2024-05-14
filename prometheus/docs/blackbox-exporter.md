# Some notes about prometheus-blackbox-exporter

## How it works?

**blackbox-exporter computes metrics performing HTTP or ICMP (ping) requests** :

* Open https://blackbox-exporter.dev.localhost/
* Try some examples :
  * https://blackbox-exporter.dev.localhost/probe?target=prometheus.io&module=http_2xx
  * https://blackbox-exporter.dev.localhost/probe?target=prometheus.io&module=icmp

## Avoid ingress exposition in production environments!

blackbox-exporter is exposed throw ingress for demo purpose. **Prefer the use of port-forwarding for debug purpose in production environments** :

```bash
# To access blackbox-exporter at https://localhost:9115/ :
kubectl -n prometheus port-forward svc/prometheus-blackbox-exporter 9115:9115
```

## Debug mode

To handle networking or permissions issues, note that a debug mode displaying "Logs for the probe" is available  :

* http://localhost:9115/probe?target=prometheus.io&module=http_2xx&debug=true
* http://localhost:9115/probe?target=prometheus.io&module=icmp&debug=true


