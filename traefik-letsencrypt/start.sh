#!/bin/bash

docker run -d --restart=unless-stopped --name traefik --net webgateway \
	-v $PWD/traefik.toml:/etc/traefik/traefik.toml:ro \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-p "80:80" -p "443:443" -p "8888:8080" \
	traefik:1.7


