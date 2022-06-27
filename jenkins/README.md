# jenkins

## Description

Docker container running jenkins with docker in docker.

WARNING : `/var/run/docker.sock` is mounted and [jenkins acquires full docker control on the docker host](https://github.com/mborne/docker-jenkins/blob/fefaab05473526f9fe25d2e8171fc9e812fe7c3e/docker-entrypoint.sh#L3-L13).

## Usage with docker-compose

* Start jenkins : `docker-compose up -d`

* Retrieve initial password `docker exec -ti jenkins cat /var/jenkins_home/secrets/initialAdminPassword`

* Open http://jenkins.localhost

## Usage with kubernetes

* 1) Start jenkins

```bash
kubectl apply -k https://github.com/mborne/docker-devbox/jenkins/manifest/local-storage
```

* 2) Get initial admin password :

```bash
JENKINS_POD=$(kubectl -n jenkins get pods -l app=jenkins --no-headers -o custom-columns=":metadata.name")
kubectl -n jenkins exec -ti $JENKINS_POD -- /bin/cat /var/jenkins_home/secrets/initialAdminPassword
```

* 3) Install and configure Kubernetes cloud plugin :

Kubernetes URL : https://kubernetes.default.svc.cluster.local


## How to configure registry access throw global environment variables?

| Variable                      | Description                                                  | Example                             |
| ----------------------------- | ------------------------------------------------------------ | ----------------------------------- |
| DOCKER_REGISTRY               | Hostname for docker registry                                 | `registry.${HOST_HOSTNAME}`         |
| DOCKER_REGISTRY_URL           | URL for docker registry                                      | `https://registry.${HOST_HOSTNAME}` |
| DOCKER_REGISTRY_CREDENTIAL_ID | Jenkins credential id to access registry (username/password) | `nexus_user`                        |

## See also

* [www.jenkins.io - Installing / Kubernetes](https://www.jenkins.io/doc/book/installing/kubernetes/) for helm instructions
* [How to Setup Jenkins Build Agents on Kubernetes Pods](https://devopscube.com/jenkins-build-agents-kubernetes/)
* [~jpetazzo/Using Docker-in-Docker for your CI or testing environment? Think twice.](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)

