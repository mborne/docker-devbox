# nexus

## Description

Repository manager for maven and docker

## Usage

* Start nexus : `docker-compose up -d`

* Retreive initial admin password : `docker exec -ti nexus cat /nexus-data/admin.password`

* Open nexus : http://nexus.localhost

* Connect with admin and initial password

* Create a docker-hosted hosted repository with http port 8082

* Test docker registry

```bash
# re-tag
docker login registry.localhost
docker tag hello-world:latest registry.localhost/hello-world:latest
# push
docker pull hello-world:latest
docker push registry.localhost/hello-world:latest
```

Check http://registry.localhost/v2/_catalog and http://registry.localhost/v2/hello-world/tags/list



