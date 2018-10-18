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

