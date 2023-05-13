#!/bin/bash

helm -n nginx-system uninstall nginx

kubectl delete namespace nginx-system

