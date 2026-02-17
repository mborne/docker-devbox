#!/bin/bash

# https://github.com/kubernetes-csi/csi-driver-smb/blob/master/charts/README.md

helm repo add csi-driver-smb https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/charts

helm repo update

# helm search repo csi-driver-smb
helm -n kube-system upgrade --install csi-driver-smb csi-driver-smb/csi-driver-smb --version 1.19.1

