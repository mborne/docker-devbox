# Using mkcert to generate traefik certificates

## Requirements

* [mkcert](https://github.com/FiloSottile/mkcert#mkcert) (binaries : [https://github.com/FiloSottile/mkcert/releases/latest](https://github.com/FiloSottile/mkcert/releases/latest))
* [traefik](README.md) started with docker compose

## Usage

* Generate and install rootCA : `mkcert -install` (1)
* Generate and add certs to traefik with helper script [mkcert/generate.sh](mkcert/generate.sh)

```bash
# For *.dev.localhost :
bash mkcert/generate.sh
# For *.example.net
DEVBOX_HOSTNAME=example.net bash mkcert/generate.sh
```
> (1) sudo password is required

## Using mkcert with a non sudo user

Note that you can manually install `rootCA.pem` :

* `mkcert -CAROOT` will display path to directory containing `rootCA.pem` and `rootCA-key.pem` (ex : `/home/mickael/.local/share/mkcert`)
* `rootCA.pem` can be imported in firefox
* The following commands allows to import `rootCA.pem` in system store with a different user :

```bash
# copy the new CA to /usr/local/share/ca-certificates
sudo cp /path/to/mkcert/rootCA.pem /usr/local/share/ca-certificates/mkcert-root-ca.crt
# update system store
sudo update-ca-certificates
```

