#!/bin/bash

helm -n kubernetes-dashboard uninstall kubernetes-dashboard

kubectl delete namespace kubernetes-dashboard

