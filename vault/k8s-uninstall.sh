#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Uninstall vault
helm -n vault uninstall vault

# Delete namespace (with StatefulSet PVC)
kubectl delete namespace vault

