#!/bin/bash

#-----------------------------------------------------------
# This script generates a kind cluster configuration file 
# based on environment variables.
#-----------------------------------------------------------

echo "# kind/config/generate.sh with :"

#-------------------------------------------
# General cluster configuration
#-------------------------------------------

# Cluster name default to devbox
KIND_CLUSTER_NAME=${KIND_CLUSTER_NAME:-devbox}
echo "# - KIND_CLUSTER_NAME=${KIND_CLUSTER_NAME}"

# Number of worker nodes
KIND_WORKER_COUNT=${KIND_WORKER_COUNT:-3}
echo "# - KIND_WORKER_COUNT=${KIND_WORKER_COUNT}"

#-------------------------------------------
# OIDC configuration
#-------------------------------------------

# URL of the OIDC provider, if empty OIDC will be disabled
KIND_OIDC_ISSUER_URL=${KIND_OIDC_ISSUER_URL:-""}
echo "# - KIND_OIDC_ISSUER_URL=${KIND_OIDC_ISSUER_URL}"

# Required value used to check audience in OIDC token
KIND_OIDC_CLIENT_ID=${KIND_OIDC_CLIENT_ID:-"kubernetes"}
echo "# - KIND_OIDC_CLIENT_ID=${KIND_OIDC_CLIENT_ID}"

# Name of the claim in OIDC token to use as username
KIND_OIDC_USERNAME_CLAIM=${KIND_OIDC_USERNAME_CLAIM:-"email"}
echo "# - KIND_OIDC_USERNAME_CLAIM=${KIND_OIDC_USERNAME_CLAIM}"

# Prefix to add to username from OIDC token, to avoid conflicts with Kubernetes usernames
KIND_OIDC_USERNAME_PREFIX=${KIND_OIDC_USERNAME_PREFIX:-"oidc:"}
echo "# - KIND_OIDC_USERNAME_PREFIX=${KIND_OIDC_USERNAME_PREFIX}"

# Name of the claim in OIDC token to use as groups
KIND_GROUPS_CLAIM=${KIND_GROUPS_CLAIM:-"groups"}
echo "# - KIND_GROUPS_CLAIM=${KIND_GROUPS_CLAIM}"

# Prefix to add to group names from OIDC token, to avoid conflicts with Kubernetes groups
KIND_OIDC_GROUPS_PREFIX=${KIND_OIDC_GROUPS_PREFIX:-"oidc:"}
echo "# - KIND_OIDC_GROUPS_PREFIX=${KIND_OIDC_GROUPS_PREFIX}"

# Expose 80 and 443 ports on master node
KIND_INGRESS_READY=${KIND_INGRESS_READY:-1}
echo "# - KIND_INGRESS_READY=${KIND_INGRESS_READY}"

# Enables ResourceQuota admission controller by default
# https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/
KIND_ADMISSION_PLUGINS=${KIND_ADMISSION_PLUGINS:-NodeRestriction,ResourceQuota}
echo "# - KIND_ADMISSION_PLUGINS=${KIND_ADMISSION_PLUGINS}"

# Allows to select Kubernetes Version, see:
# - https://kind.sigs.k8s.io/docs/user/configuration/#kubernetes-version 
# - https://github.com/kubernetes-sigs/kind/releases
KIND_IMAGE=${KIND_IMAGE:-kindest/node:v1.33.4@sha256:25a6018e48dfcaee478f4a59af81157a437f15e6e140bf103f85a2e7cd0cbbf2}

# Allows to use another CNI like canal
KIND_CNI=${KIND_CNI:-default}
echo "# - KIND_CNI=${KIND_CNI}"
if [ "$KIND_CNI" != "default" ] && [ "$KIND_CNI" != "disabled" ];
then
  DISABLE_DEFAULT_CNI=1
else
  DISABLE_DEFAULT_CNI=0
fi
echo "# - DISABLE_DEFAULT_CNI=${DISABLE_DEFAULT_CNI}"

#----------------------------------------
# Generate kind config
#----------------------------------------

cat <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: ${KIND_CLUSTER_NAME}
networking:
  ipFamily: ipv4
  apiServerAddress: "127.0.0.1"
  apiServerPort: 6443
EOF
if [ $DISABLE_DEFAULT_CNI == 1 ];
then
cat <<EOF
  podSubnet: "10.244.0.0/16"
  serviceSubnet: "10.96.0.0/12"
  disableDefaultCNI: true
EOF
fi

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
  image: ${KIND_IMAGE}
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

if [ ! -z "$KIND_OIDC_ISSUER_URL" ];
then
cat <<EOF
  - |
    kind: ClusterConfiguration
    apiServer:
        extraArgs:
          enable-admission-plugins: $KIND_ADMISSION_PLUGINS
          oidc-issuer-url: $KIND_OIDC_ISSUER_URL
          oidc-client-id: "$KIND_OIDC_CLIENT_ID"
          oidc-groups-claim: "$KIND_GROUPS_CLAIM"
          oidc-groups-prefix: "$KIND_OIDC_GROUPS_PREFIX"
          oidc-username-claim: "$KIND_OIDC_USERNAME_CLAIM"
          oidc-username-prefix: "$KIND_OIDC_USERNAME_PREFIX"
EOF
fi

if [ "$KIND_INGRESS_READY" != "0" ];
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

for i in $(seq 1 $KIND_WORKER_COUNT);
do
cat <<EOF
- role: worker
  image: ${KIND_IMAGE}
  extraMounts:
  - hostPath: /var/devbox
    containerPath: /devbox
EOF
done


