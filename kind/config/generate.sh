#!/bin/bash

#----------------------------------------
# Handle params
#----------------------------------------

# Cluster name default to devbox
CLUSTER_NAME=${CLUSTER_NAME:-devbox}

# Number of worker nodes
WORKER_COUNT=${WORKER_COUNT:-2}

# Required value to enable OIDC
OIDC_ISSUER_URL=${OIDC_ISSUER_URL:-""}

# Expose 80 and 443 ports on master node
INGRESS_READY=${INGRESS_READY:-1}

#----------------------------------------
# Generate kind config
#----------------------------------------

cat <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: ${CLUSTER_NAME}
networking:
  ipFamily: ipv4
  apiServerAddress: "127.0.0.1"
  apiServerPort: 6443
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
EOF

if [ ! -z "$OIDC_ISSUER_URL" ];
then
cat <<EOF
  - |
    kind: ClusterConfiguration
    apiServer:
        extraArgs:
          oidc-issuer-url: $OIDC_ISSUER_URL
          oidc-client-id: kubernetes
          oidc-groups-claim: groups
          oidc-groups-prefix: "oidc:"
          oidc-username-claim: email
          oidc-username-prefix: "oidc:"
EOF
fi

if [ "$INGRESS_READY" != "0" ];
then
cat <<EOF
  extraPortMappings:
  - containerPort: 30000
    hostPort: 80
    protocol: TCP
  - containerPort: 30001
    hostPort: 443
    protocol: TCP
EOF
fi

for i in $(seq 1 $WORKER_COUNT);
do
cat <<EOF
- role: worker
EOF
done


