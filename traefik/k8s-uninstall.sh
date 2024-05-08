#!/bin/bash

helm -n traefik-system uninstall traefik
kubectl delete namespace traefik-system

