#!/bin/bash

# uninstall headlamp
helm -n headlamp uninstall headlamp

# remove namespace
kubectl delete namespace headlamp

