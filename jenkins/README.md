# jenkins

## Description

Docker container with jenkins

## Usage

* 1) Start jenkins : `docker-compose up -d`

* 2) Retrieve initial password `docker exec -ti jenkins cat /var/jenkins_home/secrets/initialAdminPassword`

* 3) Open http://localhost:8180


