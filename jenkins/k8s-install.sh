#!/bin/bash

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-mkcert}

# Add helm repo
helm repo add jenkins https://charts.jenkins.io

# Update helm repos
helm repo update

# # Create namespace jenkins if not exists
# kubectl create namespace jenkins --dry-run=client -o yaml | kubectl apply -f -

# Deploy with helm
helm -n jenkins upgrade --install --create-namespace jenkins jenkins/jenkins

# Create IngressRoute with dynamic hostname
cat <<EOF | kubectl -n jenkins apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: jenkins
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: jenkins.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: jenkins
            port:
              number: 8080
  tls:
  - hosts:
    - jenkins.$DEVBOX_HOSTNAME
    secretName: jenkins-cert
EOF
