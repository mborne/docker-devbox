# dnsmasq

## Description

Allows container name resolution from host.

## How it works?

`dnsmasq` is running in a container with a static IP (`192.168.150.2`) to :

* Resolve `*.localhost` as `127.0.0.1` and to use `192.168.150.2`
* Resolve `<CONTAINER_ID>.<NETWORD_NAME>` (ex : `openldap.devbox`) with the [docker embedded DNS server](https://docs.docker.com/v17.09/engine/userguide/networking/configure-dns/) (`127.0.0.11`)
* Forward other name resolution to external DNS servers ([cloudflare](https://www.cloudflare.com/fr-fr/dns/) by default)


## Usage

* Start dnsmasq : `docker-compose up -d --build`

* Test service :

  * `dig @192.168.150.2 dnsmasq.devbox`
  * `dig @192.168.150.2 github.com`

* Configure system to use `192.168.150.2` as a DNS server



