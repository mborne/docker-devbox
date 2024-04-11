# prometheus-blackbox-exporter

## How it works?

* Forward port from http://localhost:9115 to prometheus-blackbox-exporter service :

```bash
kubectl -n prometheus port-forward svc/prometheus-blackbox-exporter 9115:9115
```

* Open http://localhost:9115

* Try some examples :
  * http://localhost:9115/probe?target=prometheus.io&module=http_2xx
  * http://localhost:9115/probe?target=prometheus.io&module=icmp


## Debug mode

Note that a debug mode displaying "Logs for the probe" is available to handle networking or permissions issues :

* http://localhost:9115/probe?target=prometheus.io&module=http_2xx&debug=true
* http://localhost:9115/probe?target=prometheus.io&module=icmp&debug=true

