#

# Deploy prometheus-operator without grafana
helm -n prometheus delete kube-prometheus-stack

# Deploy prometheus-blackbox-exporter with sample ServiceMonitors
helm -n prometheus delete prometheus-blackbox-exporter


