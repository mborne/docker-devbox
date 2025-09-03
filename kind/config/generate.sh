#!/bin/bash

#----------------------------------------
# Handle params
#----------------------------------------
echo "# kind/config/generate.sh with :"
# Cluster name default to devbox
KIND_CLUSTER_NAME=${KIND_CLUSTER_NAME:-devbox}
echo "# - KIND_CLUSTER_NAME=${KIND_CLUSTER_NAME}"

# Number of worker nodes
KIND_WORKER_COUNT=${KIND_WORKER_COUNT:-3}
echo "# - KIND_WORKER_COUNT=${KIND_WORKER_COUNT}"

# Required value to enable OIDC
KIND_OIDC_ISSUER_URL=${KIND_OIDC_ISSUER_URL:-""}
echo "# - KIND_OIDC_ISSUER_URL=${KIND_OIDC_ISSUER_URL}"

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
KIND_IMAGE=${KIND_IMAGE:-kindest/node:v1.32.8@sha256:abd489f042d2b644e2d033f5c2d900bc707798d075e8186cb65e3f1367a9d5a1}

# Allows to use another CNI like canal
KIND_CNI=${KIND_CNI:-default}
echo "# - KIND_CNI=${KIND_CNI}"
if [ "$KIND_CNI" != "default" ] || [ "$KIND_CNI" != "disabled" ];
then
  DISABLE_DEFAULT_CNI=true
else
  DISABLE_DEFAULT_CNI=false
fi

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
          oidc-client-id: kubernetes
          oidc-groups-claim: groups
          oidc-groups-prefix: "oidc:"
          oidc-username-claim: email
          oidc-username-prefix: "oidc:"
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


