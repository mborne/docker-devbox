#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-mkcert}

echo "---------------------------------------------"
echo "-- kubernetes-dashboard"
echo "---------------------------------------------"

helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo update

# Create namespace kubernetes-dashboard if not exists
kubectl create namespace kubernetes-dashboard --dry-run=client -o yaml | kubectl apply -f -

# Install kubernetes-dashboard
helm -n kubernetes-dashboard upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard

# Create admin-user ServiceAccount
kubectl -n kubernetes-dashboard apply -k ${SCRIPT_DIR}/manifest/sa-admin-user.yaml

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
  - host: dashboard.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: ImplementationSpecific
        path: "/"
        backend:
          service:
            name: kubernetes-dashboard-kong-proxy
            port:
              number: 443
  tls:
  - hosts:
    - dashboard.$DEVBOX_HOSTNAME
    secretName: kube-dashboard-cert
EOF


# # Display resources
# kubectl -n kubernetes-dashboard get pods,svc,ingress


