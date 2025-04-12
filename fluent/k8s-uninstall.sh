#/bin/bash

# Uninstall fluent-bit with helm
helm -n fluent uninstall fluent-bit

# Remove clusterrolebinding
kubectl delete clusterrolebinding fluent-bit-read
