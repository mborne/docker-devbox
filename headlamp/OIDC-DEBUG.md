# Headlamp - OIDC debug notes...

* Ensure that all authenticated users have cluster-admin permissions :

```bash
# DON'T USE THIS ON PROD / PUBLIC CLUSTERS!
kubectl create clusterrolebinding everybody-is-cluster-admin  --clusterrole=cluster-admin --group='system:authenticated'

# check permissions at K8S level
kubectl auth can-i list pods --as=system:authenticated
kubectl auth can-i list pods --as=oidc:mborne@example.net
kubectl auth can-i list pods --as=mborne@example.net
```

* Deploy headlamp with OIDC support :

```bash
export HEADLAMP_OIDC_ENABLED=1
export HEADLAMP_OIDC_ISSUER_URL=https://keycloak.quadtreeworld.net/
export HEADLAMP_OIDC_CLIENT_ID=headlamp
export HEADLAMP_OIDC_CLIENT_SECRET=XXXXXXXXXXXXXXXXXXXXXX
export HEADLAMP_OIDC_SCOPES="openid email profile"
# ${HEADLAMP_OIDC_ISSUER_URL}/protocol/openid-connect/userinfo
export HEADLAMP_OIDC_ISSUER_INFO_URL="${HEADLAMP_OIDC_ISSUER_URL}/protocol/openid-connect/userinfo"

# preview helm values
bash headlamp/helm/values.sh

# deploy
bash headlamp/k8s-install.sh
```

