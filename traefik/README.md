# traefik

## Description

Auto-configured reverse proxy according to container labels.

## Usage

* Start traefik : `docker-compose up -d`

* See http://traefik.localhost for web-ui

* Run [whoami](../whoami/README.md) to test traefik

## Warning

Traefik is listening only on localhost because exposing `80:80` might cause security issue as [UFW](https://help.ubuntu.com/community/UFW) rules would be ignored.

