# Valkey

Container running [Valkey](https://valkey.io/) (forked from [Redis](../redis/README.md)).

## Usage with docker

* Start : `docker compose up -d`
* Note that valkey is exposed on port 6379
* Test with embedded valkey-cli : `docker exec -ti valkey valkey-cli`

```bash
#127.0.0.1:6379> AUTH ChangeIt
#OK
127.0.0.1:6379> ping
PONG
127.0.0.1:6379> set mykey somevalue
OK
127.0.0.1:6379> get mykey
"somevalue"
127.0.0.1:6379> quit
```


## Usage with Kubernetes

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
VALKEY_PASSWORD=ChangeIt bash k8s-install.sh
```

* Check pod status : `kubectl -n valkey get services,pods`
* Test with embedded client : `kubectl -n valkey exec -ti valkey-0 -- valkey-cli`

## Resources

* [valkey.io](https://valkey.io/)
* [valkey.io - Quick start guide](https://valkey.io/topics/quickstart/)
* [valkey.io - Commands](https://valkey.io/commands/)

Helm chart :

* [github.com - valkey-io/valkey-helm](https://github.com/valkey-io/valkey-helm/tree/main/valkey#valkey) with default values [values.yaml](https://github.com/valkey-io/valkey-helm/blob/main/valkey/values.yaml)

