#!/bin/bash

# Uninstall whoami
helm -n whoami uninstall whoami

kubectl -n whoami delete ingress/whoami

# Remove ingress

# Create Ingress with dynamic hostname
cat <<EOF | kubectl -n whoami apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: whoami
  annotations:
    cert-manager.io/cluster-issuer: "${DEVBOX_ISSUER}"
spec:
  ingressClassName: ${DEVBOX_INGRESS}
  rules:
  - host: whoami.$DEVBOX_HOSTNAME
    http:
      paths:
      - pathType: ImplementationSpecific
        path: "/"
        backend:
          service:
            name: whoami
            port:
              number: 80
  tls:
  - hosts:
    - whoami.$DEVBOX_HOSTNAME
    secretName: whoami-cert
EOF

kubectl wait --namespace whoami \
    --for=condition=ready pod \
    --selector=app=whoami \
    --timeout=90s

# Display resources
kubectl -n whoami get pods,svc,ingress
