# Kubernetes with OIDC authentication

## How does it work?

> See [kubernetes.io - Authentication](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#json-web-token-authentication)

The K8S API server can be configured to support OIDC authentication based on JWT tokens by adding some parameters:

```bash
# the OIDC issuer URL
--kube-apiserver-arg oidc-issuer-url=https://keycloak.quadtreeworld.net/realms/master
--kube-apiserver-arg oidc-client-id=kubernetes
--kube-apiserver-arg oidc-groups-claim=groups
--kube-apiserver-arg oidc-groups-prefix=oidc:
--kube-apiserver-arg oidc-username-claim=email
--kube-apiserver-arg oidc-username-prefix=oidc:
```

Note that :

- Prefixes avoid conflicts with K8S groups
- The `oidc-client-id` is used by K8S to control the audience of the token ("aud").
- If you use a dedicated "headlamp" client, make sure that "kubernetes" is added (for Keycloak, `Client / Mappers / Add mapper (by configuration) / Audience / (-> kubernetes / add to id token)` : [screenshot](img/keycloak-audience-kubernetes.png) )

## Using OIDC with devbox

Note that:

- [docker-devbox - kind](../kind/quickstart.sh) allows to **create a Kind cluster with OIDC support**.
- [mborne/k3s-deploy](https://github.com/mborne/k3s-deploy) does the same with a K3S cluster (see [mborne/k3s-deploy - Enabling OIDC on K3S](https://github.com/mborne/k3s-deploy/tree/master#enabling-oidc-on-k3s))
- [OVH - Managed Kubernetes Service](https://www.ovhcloud.com/fr/public-cloud/kubernetes/) allows OIDC configuration (see [help.ovhcloud.com - Configuring the OIDC provider on an OVHcloud Managed Kubernetes cluster](https://help.ovhcloud.com/csm/fr-public-cloud-kubernetes-configure-oidc-provider?id=kb_article_view&sysparm_article=KB0054948))
- Other providers like [Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine) provide an equivalent feature by binding users and groups from their IAMs.

## RBAC configuration with OIDC

> See [kubernetes.io - Using RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)

You can assign a Role or ClusterRole to users and groups. See the following examples:

```bash
# Grant "cluster-admin" role to an OIDC user :
kubectl create clusterrolebinding oidc-mborne-admin --clusterrole=cluster-admin --user='oidc:mborne@quadtreeworld.net'

# Grant "cluster-admin" role to the member of an OIDC group :
kubectl create clusterrolebinding oidc-devbox-admins --clusterrole=cluster-admin --group='oidc:devbox_admins'

# DANGEROUS: Grant "view" role to all authenticated users
kubectl create clusterrolebinding everybody-can-view-everything  --clusterrole=view --group='system:authenticated'
```

## RBAC debugging

> See [kubernetes.io - kubectl auth can-i](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_auth/kubectl_auth_can-i/)

```bash
# check permissions at K8S level
kubectl auth can-i list pods --as=system:authenticated
kubectl auth can-i list pods --as=oidc:mborne@example.net
kubectl auth can-i list pods --as=mborne@example.net
```

