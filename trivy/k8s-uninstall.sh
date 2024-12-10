#!/bin/bash

helm -n trivy-system uninstall trivy-operator
kubectl delete namespace trivy-system

