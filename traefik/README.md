# Traefik

Container running [traefik proxy](https://doc.traefik.io/traefik/).

## Usage with docker

* Build [mborne/traefik-dev](img/traefik-dev/README.md) image : `docker compose build --pull`
* Start traefik : `docker compose up -d`
* See http://traefik.dev.localhost for web-ui
* Run [whoami](../whoami/README.md) to test traefik

See also :

* [Using mkcert to generate traefik certificates](mkcert.md)
* [mborne/traefik-dev](img/traefik-dev/README.md) to customize traefik config using `docker compose exec traefik /bin/sh` and [vi](https://ryanstutorials.net/linuxtutorial/cheatsheetvi.php) editor.

## Usage with helm

See [traefik/traefik-helm-chart](https://github.com/traefik/traefik-helm-chart#traefik) :

* Add helm repository : `helm repo add traefik https://helm.traefik.io/traefik`
* Update helm repositories : `helm repo update`
* Create a namespace for traefik : `kubectl create namespace traefik-system`
* Deploy traefik with helm : `helm -n traefik-system install -f traefik/helm/local.yml traefik traefik/traefik`
* Wait for pods to be ready : `kubectl -n traefik-system get pods -w`
* To get dashboard on http://localhost:9000/dashboard/#/ : `kubectl -n traefik-system port-forward $(kubectl -n traefik-system get pods -o name) 9000:9000`
* To get dashboard on http://traefik.dev.localhost : `kubectl -n traefik-system apply -f traefik/manifest/dashboard-local.yml`

Note :

* To enable [LetsEncrypt with HTTP challenge](https://letsencrypt.org/docs/challenge-types/#http-01-challenge), see [helm/qtw-dev-values.yml](helm/qtw-dev-values.yml) and adapt it (**especially the email!**)
* See also the following sample to expose the dashboard with an IngressRoute :
  * [manifest/middleware-ipwhitelist.yaml](manifest/middleware-ipwhitelist.yaml)
  * [manifest/traefik-dashboard-http.yml](manifest/traefik-dashboard-http.yml)
  * [manifest/traefik-dashboard-le.yml](manifest/traefik-dashboard-le.yml)

## Resources

Docker :

* [knplabs.com - How to handle https with docker-compose and mkcert for local development](https://knplabs.com/en/blog/how-to-handle-https-with-docker-compose-and-mkcert-for-local-development)
* [traefik.io - blog - Traefik Proxy 2.x and TLS 101](https://traefik.io/blog/traefik-2-tls-101-23b4fbee81f1/)

Kubernetes :

* [Traefik & Kubernetes](https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/)
* [blog.tomarrell.com - Kustomize: Traefik v2.2 as a Kubernetes Ingress Controller](https://blog.tomarrell.com/post/traefik_v2_on_kubernetes)
* [www.grottedubarbu.fr - Traefik 2.2 + K3S](https://www.grottedubarbu.fr/traefik-2-k3s/)
* [www.grottedubarbu.fr - Kubernetes : Kustomize & Traefik](https://www.grottedubarbu.fr/kubernetes-kustomize-traefik/)

Other :

* [thomseddon/traefik-forward-auth](https://github.com/thomseddon/traefik-forward-auth#readme)
