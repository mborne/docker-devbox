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

# Enables ResourceQuota admission controller by default
# https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/
ADMISSION_PLUGINS=${ADMISSION_PLUGINS:-NodeRestriction,ResourceQuota}

# Allows to use another CNI like canal
DISABLE_DEFAULT_CNI=${DISABLE_DEFAULT_CNI:-false}

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
  podSubnet: "10.244.0.0/16"
  serviceSubnet: "10.96.0.0/12"
  disableDefaultCNI: $DISABLE_DEFAULT_CNI
EOF

if [ ! -z "$DOCKERHUB_PROXY" ];
then
cat <<EOF
containerdConfigPatches:
  - |-
    [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
      endpoint = ["$DOCKERHUB_PROXY"]
EOF
fi

cat <<EOF
nodes:
- role: control-plane
  extraMounts:
  - hostPath: /var/devbox
    containerPath: /devbox
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
          enable-admission-plugins: $ADMISSION_PLUGINS
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
  extraMounts:
  - hostPath: /var/devbox
    containerPath: /devbox
EOF
done


