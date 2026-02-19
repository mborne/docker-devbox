# Headlamp

Container running [Headlamp](https://headlamp.dev/), the "user-friendly Kubernetes UI focused on extensibility"

## Usage with Kubernetes

!!!warning "Security warning"
    A ServiceAccount named "admin-user" will be created in the headlamp namespace.

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
bash headlamp/k8s-install.sh
```


* Get admin-user token :

```bash
kubectl -n headlamp create token admin-user
```

* Open https://dashboard.dev.localhost

## OIDC

!!!warning "Currently not working with my Keycloak instance..."
    - `/clusters/main/me` is OK (email and groups)
    - `/clusters/main/healthz` falls on "401 Unauthorized" with no logs even with cluster-admin permission for all authenticated users...

See [Headlamp - OIDC debug notes...](OIDC-DEBUG.md) (another motivation to learn Go to add logs ;))

## Debug

```bash
# preview helm values
bash headlamp/helm/values.sh

# get helm values
helm -n headlamp get values headlamp
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


