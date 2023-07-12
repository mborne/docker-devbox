#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-mkcert}

echo "---------------------------------------------"
echo "-- kubernetes-dashboard"
echo "---------------------------------------------"

# Create namespace kubernetes-dashboard if not exists
kubectl create namespace kubernetes-dashboard --dry-run=client -o yaml | kubectl apply -f -

# Deploy traefik with helm
kubectl -n kubernetes-dashboard apply -k ${SCRIPT_DIR}/manifest/base

# Create Ingress with dynamic hostname
cat <<EOF | kubectl -n kubernetes-dashboard apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: kubernetes-dashboard
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
    traefik.ingress.kubernetes.io/service.serversscheme: https
    traefik.ingress.kubernetes.io/router.tls: "true"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: kube-dashboard.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: ImplementationSpecific
        path: "/"
        backend:
          service:
            name: kubernetes-dashboard
            port:
              number: 443
  tls:
  - hosts:
    - kube-dashboard.$DEVBOX_HOSTNAME
    secretName: kube-dashboard-cert
EOF


# Display resources
kubectl -n kubernetes-dashboard get pods,svc,ingress


