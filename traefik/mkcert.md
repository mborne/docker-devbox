# Using mkcert to generate traefik certificates

## Requirements

* [mkcert](https://github.com/FiloSottile/mkcert#mkcert) (binaries : [https://github.com/FiloSottile/mkcert/releases/latest](https://github.com/FiloSottile/mkcert/releases/latest))
* [traefik](README.md) started with docker compose

## Usage

* Generate and install [mkcert](https://github.com/FiloSottile/mkcert#mkcert) root CA : `mkcert -install`
* Generate and add certs to traefik with helper script [mkcert/generate.sh](mkcert/generate.sh) : `bash mkcert/generate.sh`
