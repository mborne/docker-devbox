#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}

# Create namespace traefik-system if not exists
kubectl create namespace longhorn-system --dry-run=client -o yaml | kubectl apply -f -

# Deploy longhorn
kubectl -n longhorn-system apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.3.2/deploy/longhorn.yaml

# Create IngressRoute with dynamic hostname
cat <<EOF | kubectl -n longhorn-system apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: longhorn-system
  name: longhorn-ingress
  annotations:
    kubernetes.io/ingress.class: "traefik"
spec:
  rules:
    - host: longhorn.${DEVBOX_HOSTNAME}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: longhorn-frontend
                port:
                  number: 80
EOF