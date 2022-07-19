# Jenkins

## Description

Docker container running [Jenkins](https://www.jenkins.io/).

## Usage with docker-compose

See [github.com - mborne/docker-jenkins](https://github.com/mborne/docker-jenkins#docker-jenkins)

## Usage with kubernetes

* 1) Start jenkins

```bash
kubectl apply -k https://github.com/mborne/docker-devbox/jenkins/manifest/local-storage
```

* 2) Wait until jenkins is running : `kubectl -n jenkins get all -o wide`

* 3) Get initial admin password :

```bash
kubectl -n jenkins exec -ti pod/jenkins-0 -- /bin/cat /var/jenkins_home/secrets/initialAdminPassword
```

* 4) Install and configure [Kubernetes cloud plugin](https://plugins.jenkins.io/kubernetes/) :
  * Kubernetes URL : https://kubernetes.default.svc.cluster.local
  * Jenkins URL : http://jenkins.jenkins.svc.cluster.local:8080



## See also

* [www.jenkins.io - Installing / Kubernetes](https://www.jenkins.io/doc/book/installing/kubernetes/) for helm instructions
* [devopscube.com - How to Setup Jenkins Build Agents on Kubernetes Pods](https://devopscube.com/jenkins-build-agents-kubernetes/)
* [jpetazzo.github.io - Using Docker-in-Docker for your CI or testing environment? Think twice.](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)
* [akomljen.com - Set Up a Jenkins CI/CD Pipeline with Kubernetes](https://akomljen.com/set-up-a-jenkins-ci-cd-pipeline-with-kubernetes/)
* [itnext.io - Jenkins + k8s: Building Docker Image without Docker](https://itnext.io/jenkins-k8s-building-docker-image-without-docker-d41cffdbda5a)

