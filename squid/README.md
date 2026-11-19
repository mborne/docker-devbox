# squid

Container running [ubuntu/squid](https://hub.docker.com/r/ubuntu/squid) in order to debug support of a corporate proxy for some tools.

## Usage with docker

* Start : `docker compose up -d`
* Test :

```bash
curl -vv -x http://127.0.0.1:3128 https://ipinfo.io
# check logs
docker logs squid
```

* Configure the corresponding environment variables :

```bash
export HTTP_PROXY=http://localhost:3128
export HTTPS_PROXY=http://localhost:3128
export NO_PROXY=127.0.0.1,localhost
```

