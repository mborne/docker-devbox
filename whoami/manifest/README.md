# Kustomize manifests to deploy containous/whoami

## base - Deployment and Service

[base/kustomization.yaml](base/kustomization.yaml) aggregates the following definitions :

* [base/deployment.yaml](base/deployment.yaml)
* [base/service.yaml](base/service.yaml)

## localhost - Deployment, Service and Ingress for localhost

[localhost/kustomization.yaml](localhost/kustomization.yaml) extends [base/kustomization.yaml](base/kustomization.yaml) with [localhost/ingress.yaml](localhost/ingress.yaml)

## qtw-dev - Deployment, Service and Ingress with custom domain

[qtw-dev/kustomization.yaml](qtw-dev/kustomization.yaml) extends [localhost/kustomization.yaml](localhost/kustomization.yaml) and patchs [localhost/ingress.yaml](localhost/ingress.yaml) with [whoami/manifest/qtw-dev/ingress-patch.json](whoami/manifest/qtw-dev/ingress-patch.json)

