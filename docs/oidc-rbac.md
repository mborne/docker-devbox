
# OIDC - Assign roles to users and groups

```bash

# bind oidc:devbox_admins group to "cluster-admin" role
kubectl create clusterrolebinding oidc-cluster-admin --clusterrole=cluster-admin --group='oidc:devbox_admins'

# DANGEROUS bind view role to all authenticated users
kubectl create clusterrolebinding everybody-is-cluster-admin  --clusterrole=view --group='system:authenticated'
```
