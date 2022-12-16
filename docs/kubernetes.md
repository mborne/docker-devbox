# Notes about Kubernetes

## Key points

* [Kustomize](https://kustomize.io/) and [helm](https://helm.sh/) are used to manage configuration
* Deployments are mainly tested with [K3S](https://k3s.io) where default traefik setup is disabled (see [mborne/k3s-deploy](https://github.com/mborne/k3s-deploy)).
* [Traefik](../traefik/README.md) is used to provide nice URL
* Get started with [whoami](../whoami/README.md)
* **WORK IN PROGRESS** (I'm still a noob)

## Resources

* Note that [K3S](https://k3s.io) is quite trivial to setup on a single node (`DEVBOX_HOSTNAME` is defaulted to `dev.localhost` for this setup)
* You may have a look to [mborne/vagrantbox](https://github.com/mborne/vagrantbox) and [mborne/k3s-deploy](https://github.com/mborne/k3s-deploy) to create a K3S with Vagrant and Ansible.


