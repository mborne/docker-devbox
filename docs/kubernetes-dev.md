# Kubernetes - how to create a DEV instance?

**WARNING : Like docker, a local Kubernetes installer may create many virtual networks** (see `ip link`). You may use a VM to avoid IP conflict with school/enterprise network.

## Using local installers

* [kind (Kubernetes in docker)](https://kind.sigs.k8s.io/)

> See [docker-devbox - kind](../kind/README.md) folder providing [kind/quickstart.sh](../kind/quickstart.sh) script to start a kind cluster with an ingress controller, network policy supports, a dashboard,...

* [K3S](https://k3s.io/) comes with an easy setup for a single node cluster

> See [mborne/vagrantbox](https://github.com/mborne/vagrantbox) and [mborne/k3s-deploy](https://github.com/mborne/k3s-deploy) to create a K3S cluster with multiple nodes using Vagrant and Ansible.

* Note that alternatives (k3s, microk8s, minikube,...) exists

> See [landscape.cncf.io - Certified Kubernetes - Distribution](https://landscape.cncf.io/?group=certified-partners-and-providers&view-mode=card&classify=category&sort-by=name&sort-direction=asc#platform--certified-kubernetes-installer) and [thechief.io - K3d vs k3s vs Kind vs Microk8s vs Minikube](https://thechief.io/c/editorial/k3d-vs-k3s-vs-kind-vs-microk8s-vs-minikube/)

## Managed Kubernetes

Note that it is sometimes to use free credits or student accounts to create Kubernetes clusters managed by cloud providers like :

* [Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine?hl=fr)

> See [mborne/gke-playground](https://github.com/mborne/gke-playground?tab=readme-ov-file#gke-playground) aiming at quickly provisioning a GKE cluster with Terraform.

* [OVH - Managed Kubernetes Services (MKS)](https://www.ovhcloud.com/en/public-cloud/kubernetes/)

> See [Creating a cluster through Terraform](https://help.ovhcloud.com/csm/en-public-cloud-kubernetes-create-cluster-with-terraform?id=kb_article_view&sysparm_article=KB0049689)

* Note that alternatives like AKS, EKS,... exists :

> See [landscape.cncf.io - Certified Kubernetes - Hosted](https://landscape.cncf.io/?group=certified-partners-and-providers&view-mode=card&classify=category&sort-by=name&sort-direction=asc#platform--certified-kubernetes-hosted)

## Resources

* [thechief.io - K3d vs k3s vs Kind vs Microk8s vs Minikube](https://thechief.io/c/editorial/k3d-vs-k3s-vs-kind-vs-microk8s-vs-minikube/)
