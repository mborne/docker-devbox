#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-mkcert}

# Create namespace traefik-system if not exists
kubectl create namespace longhorn-system --dry-run=client -o yaml | kubectl apply -f -

# Deploy longhorn
kubectl -n longhorn-system apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.4.2/deploy/longhorn.yaml

# Create Ingress with dynamic hostname
cat <<EOF | kubectl -n longhorn-system apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: longhorn-system
  name: longhorn-ingress
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
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
  tls:
  - hosts:
    - longhorn.$DEVBOX_HOSTNAME
    secretName: longhorn-cert
EOF

# Display resources
kubectl -n longhorn-system get pods,svc,ingress
# kubectl wait --namespace onghorn-system \
#     --for=condition=ready pod \
#     --selector=app.kubernetes.io/name=cert-manager \
#     --timeout=90s