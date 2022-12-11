# Nexus

Containers running [sonatype/nexus3](https://hub.docker.com/r/sonatype/nexus3/).

## Usage with docker

* Start nexus : `docker compose up -d`

* Retrieve initial admin password : `docker exec -ti nexus cat /nexus-data/admin.password`

* Open nexus : https://nexus.dev.localhost/

* Connect with admin and initial password (`docker exec -ti nexus cat /nexus-data/admin.password`)

* Create a "docker (hosted)" repository with http port 8082

* Open https://registry.dev.localhost/v2/_catalog


## Using docker registry

```bash
# re-tag
docker login registry.dev.localhost
docker pull hello-world:latest
docker tag hello-world:latest registry.dev.localhost/hello-world:latest
# push
docker pull hello-world:latest
docker push registry.dev.localhost/hello-world:latest
```

Check https://registry.dev.localhost/v2/_catalog and https://registry.dev.localhost/v2/hello-world/tags/list

