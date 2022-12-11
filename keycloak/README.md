# Keycloak

Container running [Keycloak](https://www.keycloak.org/).

## Usage with docker

* Start keycloak stack : `KEYCLOAK_ADMIN_PASSWORD=ChangeIt docker compose up -d`

* Open http://keycloak.dev.localhost

* See OpenID connect : http://keycloak.dev.localhost/realms/master/.well-known/openid-configuration

## Ressources

* [Notes about admin API](docs/admin-api.md)
