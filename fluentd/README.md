# Fluentd


```
docker run --log-driver=fluentd --log-opt tag="docker.{{.ID}}" ubuntu echo "Hello Fluentd!"
```

## Reference

* [docs.fluentd.org - container-deployment/docker-compose](https://docs.fluentd.org/container-deployment/docker-compose)

