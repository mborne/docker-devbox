#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}

# Create namespace kubernetes-dashboard if not exists
kubectl create namespace kubernetes-dashboard --dry-run=client -o yaml | kubectl apply -f -

# Deploy traefik with helm
kubectl -n kubernetes-dashboard apply -k manifest/base

# Create IngressRoute with dynamic hostname
cat <<EOF | kubectl -n kubernetes-dashboard apply -f -
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRouteTCP
metadata:
  name: k8s-dashboard
spec:
  entryPoints:                  
    - websecure
  routes:                      
  - match: HostSNI(\`k8s-dashboard.$DEVBOX_HOSTNAME\`)
    services:
    - name: kubernetes-dashboard
      port: 443
  tls:
    passthrough: true
EOF
