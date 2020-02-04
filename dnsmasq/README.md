# dnsmasq

## Description

Allows container name resolution from host.

## Usage

* Start dnsmasq : `docker-compose up -d --build`

* Test service :

  * `dig @192.168.150.2 dnsmasq.devbox`
  * `dig @192.168.150.2 github.com`

* Configure system to use `192.168.150.2` as a DNS server



