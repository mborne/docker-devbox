# nexus

## Description

Repository manager for maven and docker

## Usage

* 1) Start nexus : `docker-compose up -d`

* 2) Open nexus : http://nexus.localhost

* 3) Connect with admin/admin123 and change password

* 4) Create a docker-hosted hosted repository with http port 8082

* 5) Test docker registry

```bash
# re-tag
docker login registry.localhost
docker tag hello-world:latest registry.localhost/hello-world:latest
# push
docker pull hello-world:latest
docker push registry.localhost/hello-world:latest
```

Check http://registry.localhost/v2/_catalog and http://registry.localhost/v2/hello-world/tags/list



