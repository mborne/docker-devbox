#!/bin/bash

kubectl create namespace postgis

helm -n postgis upgrade --install gis oci://registry-1.docker.io/bitnamicharts/postgresql
