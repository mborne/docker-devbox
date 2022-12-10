# Jenkins

Container running [Jenkins](https://www.jenkins.io/).

## Usage with docker

See [github.com - mborne/docker-jenkins](https://github.com/mborne/docker-jenkins#docker-jenkins)

## Usage with kubernetes

* 1) Start jenkins

```bash
kubectl apply -k https://github.com/mborne/docker-devbox/jenkins/manifest/local-storage
```

* 2) Wait until jenkins is running : `kubectl -n jenkins get pods -w`

* 3) Get initial admin password :

```bash
kubectl -n jenkins exec -ti pod/jenkins-0 -- /bin/cat /var/jenkins_home/secrets/initialAdminPassword
```

* 4) Open http://jenkins.dev.localhost

## Usage with helm

* 1) Add helm repo : `helm repo add jenkins https://charts.jenkins.io`
* 2) Update helm repos : `helm repo update`
* 3) Create jenkins namespace : `kubectl create namespace jenkins`
* 4) Deploy with helm : `helm -n jenkins install -f helm/local-values.yml jenkins jenkins/jenkins` (**note that you may adapt [helm/local-values.yml](helm/local-values.yml)**)
* 5) Follow helm instructions

Notes :

* Redeploy with helm : `helm -n jenkins upgrade -f helm/qtw-values.yml jenkins jenkins/jenkins`
* Uninstall with helm : `helm -n jenkins upgrade -f helm/qtw-values.yml jenkins jenkins/jenkins`

## Kubernetes cloud plugin

* Install and configure [Kubernetes cloud plugin](https://plugins.jenkins.io/kubernetes/) :
  * Kubernetes URL : https://kubernetes.default.svc.cluster.local
  * Jenkins URL : http://jenkins.jenkins.svc.cluster.local:8080
* See samples Jenkinsfile :
  * [samples/kube-jnlp/Jenkinsfile](samples/kube-jnlp/Jenkinsfile)
  * [samples/kube-validator/Jenkinsfile](samples/kube-validator/Jenkinsfile) with PVC for maven cache [samples/kube-validator/maven-repo-storage.yaml](samples/kube-validator/maven-repo-storage.yaml)

## See also

* [www.jenkins.io - Installing / Kubernetes](https://www.jenkins.io/doc/book/installing/kubernetes/) for helm instructions
* [devopscube.com - How to Setup Jenkins Build Agents on Kubernetes Pods](https://devopscube.com/jenkins-build-agents-kubernetes/)
* [jpetazzo.github.io - Using Docker-in-Docker for your CI or testing environment? Think twice.](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)
* [akomljen.com - Set Up a Jenkins CI/CD Pipeline with Kubernetes](https://akomljen.com/set-up-a-jenkins-ci-cd-pipeline-with-kubernetes/)
* [itnext.io - Jenkins + k8s: Building Docker Image without Docker](https://itnext.io/jenkins-k8s-building-docker-image-without-docker-d41cffdbda5a)

