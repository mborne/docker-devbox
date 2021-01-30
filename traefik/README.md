# traefik

## Description

Auto-configured reverse proxy according to container labels.

## Usage

* Start traefik : `docker-compose up -d`

* See http://traefik.localhost for web-ui

* Run [whoami](../whoami/README.md) to test traefik

## Warning

* Traefik is listening only on localhost because exposing `80:80` might cause security issue as `iptables`/[UFW](https://help.ubuntu.com/community/UFW) rules are bypassed by docker.
* It's better to install traefik as a service (traefik sees real client IP and there is no need for containers to share a common network with traefik)
