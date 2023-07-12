# Kubernetes - how to create a DEV instance?

**WARNING : Like docker, a local Kubernetes installer may create many virtual networks** (see `ip link`). Use a VM to avoid IP conflict with school/enterprise network.

## Local installers

* [kind (Kubernetes in docker)](https://kind.sigs.k8s.io/)

> Note that implementing Ingress or LoadBalancer requires more work than K3S. See [docker-devbox/kind - Usage with Ingress](../kind/README.md#usage-with-ingress).

* [K3S](https://k3s.io/) comes with an easy setup 

> See [mborne/vagrantbox](https://github.com/mborne/vagrantbox) and [mborne/k3s-deploy](https://github.com/mborne/k3s-deploy) to create a K3S cluster using Vagrant and Ansible


## Resources

* [thechief.io - K3d vs k3s vs Kind vs Microk8s vs Minikube](https://thechief.io/c/editorial/k3d-vs-k3s-vs-kind-vs-microk8s-vs-minikube/)
