# mborne/traefik-dev

## Description

[traefik](https://doc.traefik.io/traefik/) image customized to ease DEV environment setup.

## Customize configuration

You can store `/etc/traefik` in a named volume (ex : `traefik-config`) and edit the following file after container startup :

* [/etc/traefik/traefik.toml](config/traefik.toml)
* [/etc/traefik/conf.d/middleware-cors.toml](config/conf.d/middleware-cors.yaml)
* [/etc/traefik/conf.d/middleware-whitelist.yaml](config/conf.d/middleware-whitelist.yaml)
* [/etc/traefik/conf.d/middleware-security-headers.toml](config/conf.d/middleware-security-headers.yaml)
* [/etc/traefik/conf.d/tls-certificates.yaml](config/conf.d/tls-certificates.yaml)

You can also add TOML or YAML files to `/etc/traefik/conf.d/` directory.

But note that `/etc/traefik/conf.d/dashboard.toml` is generated at runtime to expose dashboard on `traefik.${HOST_HOSTNAME}` domain (see [entrypoint.sh](entrypoint.sh))

