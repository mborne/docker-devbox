
# OIDC - Assign roles to users and groups

```bash

kubectl create clusterrolebinding anonymous-view  --clusterrole=view --group='system:anonymous'

kubectl create clusterrolebinding authenticated-admin  --clusterrole=cluster-admin --group='system:authenticated'

# bind oidc:k8s_admin group to "cluster-admin" role
kubectl create clusterrolebinding oidc-cluster-admin --clusterrole=cluster-admin --group='oidc:devbox_admins'

# bind oidc:k8s_users group to "view" role
kubectl create clusterrolebinding oidc-cluster-user --clusterrole=view --group='oidc:devbox_dev'
```
