#!/bin/bash

kubectl -n cert-manager get secret devbox-selfsigned-ca \
  -o jsonpath='{.data.ca\.crt}' | base64 -d
