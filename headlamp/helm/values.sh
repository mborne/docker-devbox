#!/bin/bash

#-------------------------------------------------------------
# This script generates the values.yaml for headlamp helm 
# chart based on environment variables.
#-------------------------------------------------------------

# URL of the OIDC issuer (ex : https://keycloak.example.com/realms/master).
# If empty, OIDC authentication is disabled.
HEADLAMP_OIDC_ISSUER_URL=${HEADLAMP_OIDC_ISSUER_URL:-""}
if [ -z "$HEADLAMP_OIDC_ISSUER_URL" ];
then
  HEADLAMP_OIDC_ENABLED=0
else
  HEADLAMP_OIDC_ENABLED=1
fi

# OIDC client ID (required if OIDC is enabled.
#
# WARNING : 
# - audience must be consistent with --oidc-client-id used in kube-apiserver configuration
# - if you use Keycloak and a dedicated client for headlamp, add an "audience" mapper
#
HEADLAMP_OIDC_CLIENT_ID=${HEADLAMP_OIDC_CLIENT_ID:-"kubernetes"}

# OIDC client secret (required if OIDC is enabled).
HEADLAMP_OIDC_CLIENT_SECRET=${HEADLAMP_OIDC_CLIENT_SECRET}

# OIDC scopes (optional, default: "openid email profile").
HEADLAMP_OIDC_SCOPES=${HEADLAMP_OIDC_SCOPES:-"openid email profile"}

# OIDC user info URL for the profile information
# (optional, headlamp display the JWT token info if empty).
HEADLAMP_OIDC_ISSUER_INFO_URL=""

cat <<EOF
podAnnotations:
  # force headlamp to restart at each deployment
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

