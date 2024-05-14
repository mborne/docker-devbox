#!/bin/bash

INTERVAL=${INTERVAL:-"5s"}
SCRAPE_TIMEOUT=${SCRAPE_TIMEOUT:-"30s"}

if [ -z "$1" ] || [ -z "$2" ];
then
  echo "Usage: prometheus/service-monitor/create-http.sh <NAME> <TARGET>"
  exit 1
fi
NAME=$1
TARGET=$2

cat <<EOF | kubectl -n prometheus apply -f -
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: $NAME
  namespace: prometheus
spec:
  endpoints:
  - interval: $INTERVAL
    metricRelabelings:
    - action: replace
      replacement: $TARGET
      sourceLabels:
      - instance
      targetLabel: instance
    - action: replace
      replacement: $NAME
      sourceLabels:
      - target
      targetLabel: target
    params:
      module:
      - http_2xx
      target:
      - $TARGET
    path: /probe
    port: http
    scheme: http
    scrapeTimeout: $SCRAPE_TIMEOUT
  jobLabel: prometheus-blackbox-exporter
  namespaceSelector:
    matchNames:
    - prometheus
  selector:
    matchLabels:
      app.kubernetes.io/instance: prometheus-blackbox-exporter
      app.kubernetes.io/name: prometheus-blackbox-exporter
EOF



