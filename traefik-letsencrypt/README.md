# traefik

## Description

Docker container for external traefik usage with letsencrypt providing https

## Usage

* Copy template configuration : `cp traefik.toml.dist traefik.toml`

* Adapt traefik.toml : `nano traefik.toml`

* Start traefik : `docker-compose up -d`

* See http://localhost:8888
