#!/bin/bash

kubectl create -f https://raw.githubusercontent.com/longhorn/longhorn/v1.3.2/uninstall/uninstall.yaml
kubectl -n default wait --for=condition=complete job/longhorn-uninstall
kubectl delete namespace longhorn-system
