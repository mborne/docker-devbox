#!/bin/bash

# experiment bash templating to generate Helm values according to env variables

DEVBOX_HOSTNAME=${DEVBOX_HOSTNAME:-dev.localhost}
DEVBOX_INGRESS=${DEVBOX_INGRESS:-traefik}
DEVBOX_ISSUER=${DEVBOX_ISSUER:-selfsigned}

HEADLAMP_OIDC_ENABLED=${HEADLAMP_OIDC_ENABLED:-0}
HEADLAMP_OIDC_ISSUER_URL=${HEADLAMP_OIDC_ISSUER_URL}
HEADLAMP_OIDC_CLIENT_ID=${HEADLAMP_OIDC_CLIENT_ID:-headlamp}
HEADLAMP_OIDC_CLIENT_SECRET=${HEADLAMP_OIDC_CLIENT_SECRET}
HEADLAMP_OIDC_SCOPES=${HEADLAMP_OIDC_SCOPES:-"openid email profile"}
# ${HEADLAMP_OIDC_ISSUER_URL}/protocol/openid-connect/userinfo
HEADLAMP_OIDC_ISSUER_INFO_URL=""

cat <<EOF
podAnnotations:
  last_update: "$(date '+%Y%m%d%H%M%S')"
env:
  - name:  HEADLAMP_CONFIG_LOG_LEVEL
    value: "debug"
config:
  inCluster: true
  inClusterContextName: "main"
EOF
if [ "$HEADLAMP_OIDC_ENABLED" == "1" ];
then
cat <<EOF
  oidc:
    clientID: "${HEADLAMP_OIDC_CLIENT_ID}"
    clientSecret: "${HEADLAMP_OIDC_CLIENT_SECRET}"
    issuerURL: "${HEADLAMP_OIDC_ISSUER_URL}"
    scopes: "${HEADLAMP_OIDC_SCOPES}"
    meUserInfoURL: "${HEADLAMP_OIDC_ISSUER_INFO_URL}"
EOF
fi
