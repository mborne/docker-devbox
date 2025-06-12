#!/bin/bash

helm -n prefect uninstall prefect-server
helm -n prefect uninstall prefect-worker

kubectl -n prefect delete ingress prefect


