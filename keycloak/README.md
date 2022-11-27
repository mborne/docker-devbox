# keycloak

## Usage

* Start [postgis](../postgis/README.md) and `createdb keycloak`

* Start keycloak : `KEYCLOAK_ADMIN_PASSWORD=ChangeIt docker compose up -d`

* Open http://keycloak.dev.localhost

* See OpenID connect : http://keycloak.dev.localhost/realms/master/.well-known/openid-configuration

## Ressources

* [Notes about admin API](docs/admin-api.md)
