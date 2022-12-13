# Jenkins deployment with Kustomize

## Motivation

Kept as is a good example to write manifests. See for example [manifest/base/rbac.yaml](manifest/base/rbac.yaml) which illustrates `ServiceAccount`, `ClusterRole` and `ClusterRoleBinding`.


## Usage

* Start jenkins

```bash
kubectl apply -k https://github.com/mborne/docker-devbox/jenkins/manifest/local-storage
```

* Wait until jenkins is running : `kubectl -n jenkins get pods -w`

* Get initial admin password :

```bash
kubectl -n jenkins exec -ti pod/jenkins-0 -- /bin/cat /var/jenkins_home/secrets/initialAdminPassword
```

* Open http://jenkins.dev.localhost

