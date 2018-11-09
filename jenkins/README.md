# jenkins

## Description

Docker container with jenkins

## Usage

* Start jenkins : `docker-compose up -d`

* Retrieve initial password `docker exec -ti jenkins cat /var/jenkins_home/secrets/initialAdminPassword`

* Open http://localhost:8180

## Sample Jenkinsfile

* Maven project
    * [simple-maven-project/Jenkinsfile](simple-maven-project/Jenkinsfile)
    * [validator/Jenkinsfile](validator/Jenkinsfile)
* Data CI
    * [postgis-integration/Jenkinsfile](postgis-integration/Jenkinsfile)

## Notes

* [~jpetazzo/Using Docker-in-Docker for your CI or testing environment? Think twice.](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)

* `ssh username@192.168.100.1` works from jenkins





