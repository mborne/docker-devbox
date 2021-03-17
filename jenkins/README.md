# jenkins

## Description

Docker container with jenkins

## Usage

* Start jenkins : `docker-compose up -d`

* Retrieve initial password `docker exec -ti jenkins cat /var/jenkins_home/secrets/initialAdminPassword`

* Open http://jenkins.localhost

## Framework for docker slaves

### 1) Avoid docker in docker for slaves

See [~jpetazzo/Using Docker-in-Docker for your CI or testing environment? Think twice.](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)

### 2) Configure registry access throw global environment variables

| Variable                      | Description                                                  | Example                             |
| ----------------------------- | ------------------------------------------------------------ | ----------------------------------- |
| DOCKER_REGISTRY               | Hostname for docker registry                                 | `registry.${HOST_HOSTNAME}`         |
| DOCKER_REGISTRY_URL           | URL for docker registry                                      | `https://registry.${HOST_HOSTNAME}` |
| DOCKER_REGISTRY_CREDENTIAL_ID | Jenkins credential id to access registry (username/password) | `nexus_user`                        |

## Sample Jenkinsfile

* Maven project
    * [simple-maven-project/Jenkinsfile](simple-maven-project/Jenkinsfile)
    * [validator/Jenkinsfile](validator/Jenkinsfile)
* Data CI
    * [postgis-integration/Jenkinsfile](postgis-integration/Jenkinsfile)


