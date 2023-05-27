# Kubernetes - how to create a DEV instance?

## Local installers

> **WARNING : Like docker, the following tool may create many virtual networks** (see `ip link`). Use a VM to avoid IP conflict with school/enterprise network.

* [K3S](https://k3s.io/) comes with an easy setup 

> See [mborne/vagrantbox](https://github.com/mborne/vagrantbox) and [mborne/k3s-deploy](https://github.com/mborne/k3s-deploy) to create a K3S cluster using Vagrant and Ansible

* [kind (Kubernetes in docker)](https://kind.sigs.k8s.io/)

> Note that implementing Ingress or LoadBalancer requires more work than K3S.

* ...and more ( see [thechief.io - K3d vs k3s vs Kind vs Microk8s vs Minikube](https://thechief.io/c/editorial/k3d-vs-k3s-vs-kind-vs-microk8s-vs-minikube/) )


## Resources


