# Jenkins

Container running [Jenkins](https://www.jenkins.io/).

## Usage with docker

See [github.com - mborne/docker-jenkins](https://github.com/mborne/docker-jenkins#docker-jenkins)

## Usage with Kubernetes

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
# To get jenkins on http://jenkins.dev.localhost
bash k8s-install.sh
# To get jenkins on http://jenkins.example.net
DEVBOX_HOSTNAME=example.net bash k8s-install.sh
```

* Wait for pod to be ready : `kubectl -n jenkins get pod -w`

* Follow helm instruction to get your 'admin' user password :

```bash
kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
```

* Open http://jenkins.dev.localhost


## Kubernetes cloud plugin

* Install and configure [Kubernetes cloud plugin](https://plugins.jenkins.io/kubernetes/) :
  * Kubernetes URL : https://kubernetes.default.svc.cluster.local
  * Jenkins URL : http://jenkins.jenkins.svc.cluster.local:8080
* See samples Jenkinsfile :
  * [samples/kube-jnlp/Jenkinsfile](samples/kube-jnlp/Jenkinsfile)
  * [samples/kube-validator/Jenkinsfile](samples/kube-validator/Jenkinsfile) with PVC for maven cache [samples/kube-validator/maven-repo-storage.yaml](samples/kube-validator/maven-repo-storage.yaml)

## See also

* [Jenkins deployment with Kustomize](kustomize.md)
* [www.jenkins.io - Installing / Kubernetes](https://www.jenkins.io/doc/book/installing/kubernetes/) for helm instructions
* [devopscube.com - How to Setup Jenkins Build Agents on Kubernetes Pods](https://devopscube.com/jenkins-build-agents-kubernetes/)
* [jpetazzo.github.io - Using Docker-in-Docker for your CI or testing environment? Think twice.](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)
* [akomljen.com - Set Up a Jenkins CI/CD Pipeline with Kubernetes](https://akomljen.com/set-up-a-jenkins-ci-cd-pipeline-with-kubernetes/)
* [itnext.io - Jenkins + k8s: Building Docker Image without Docker](https://itnext.io/jenkins-k8s-building-docker-image-without-docker-d41cffdbda5a)

