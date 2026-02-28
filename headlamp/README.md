# Headlamp

Container running [Headlamp](https://headlamp.dev/), the "user-friendly Kubernetes UI focused on extensibility".

## Usage with Kubernetes

> **WARNING** : A ServiceAccount named "admin-user" will be created in the headlamp namespace.

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
bash headlamp/k8s-install.sh
```

* Get admin-user token :

```bash
kubectl -n headlamp create token admin-user
```

* Open https://dashboard.dev.localhost

## Headlamp with OIDC

> See [Kubernetes with OIDC authentification](../docs/k8s-oidc.md) if you are an OIDC / RBAC begginer.

See Headlamp to create a client :

- [How to Set Up Headlamp in minikube with Keycloak OIDC Authentication](https://headlamp.dev/docs/latest/installation/in-cluster/keycloak/)
- [How to Set Up Headlamp in minikube with Dex OIDC Authentication](https://headlamp.dev/docs/latest/installation/in-cluster/dex/)

Read [headlamp/helm/values.sh](helm/values.sh) and use the corresponding environments values :

```bash
# Adapt to use your Keycloak or DEX instance
export HEADLAMP_OIDC_ISSUER_URL=https://keycloak.example.com/realms/master

# WARNING : ensure that audience is consistent with OIDC_CLIENT_ID
# (I shamefully spent hours on this!)
export HEADLAMP_OIDC_CLIENT_ID=headlamp
export HEADLAMP_OIDC_CLIENT_SECRET=XXXXXXXXXXXXXXXXXXXXXX

# preview helm values
bash headlamp/helm/values.sh

# deploy
bash headlamp/k8s-install.sh
```


## Resources

* https://headlamp.dev/ : official website
* https://github.com/kubernetes-sigs/headlamp#readme
* https://headlamp.dev/docs/latest/installation/in-cluster/ : in-cluster install with helm

```bash
# first add our custom repo to your local helm repositories
helm repo add headlamp https://kubernetes-sigs.github.io/headlamp/

# now you should be able to install headlamp via helm
helm install my-headlamp headlamp/headlamp --namespace kube-system
```

* https://headlamp.dev/docs/latest/installation/in-cluster/dex/ (good news, no more need to deploy oauth2-proxy!)

```yaml
config:
  oidc:
    clientID: "<YOUR-CLIENT-ID>"
    clientSecret: "<YOUR-CLIENT-SECRET>"
    issuerURL: "<YOUR-DEX-URL>"
    scopes: "email"
```


