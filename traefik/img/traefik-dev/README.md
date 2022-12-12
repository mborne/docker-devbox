# mborne/traefik-dev

[traefik](https://doc.traefik.io/traefik/) image customized to ease DEV environment setup.

## Key points

* `/etc/traefik/conf.d/dashboard.toml` is generated at runtime to expose dashboard on `traefik.${DEVBOX_HOSTNAME}` domain (see [entrypoint.sh](entrypoint.sh))
* `/etc/traefik` is meant to be mapped to a named volume (ex : `traefik-config`) as some default configs are provided :

  * [/etc/traefik/traefik.toml](config/traefik.toml)
  * [/etc/traefik/conf.d/middleware-cors.toml](config/conf.d/middleware-cors.yaml)
  * [/etc/traefik/conf.d/middleware-whitelist.yaml](config/conf.d/middleware-whitelist.yaml)
  * [/etc/traefik/conf.d/middleware-security-headers.toml](config/conf.d/middleware-security-headers.yaml)
  * [/etc/traefik/conf.d/tls-certificates.yaml](config/conf.d/tls-certificates.yaml)

* Some custom TOML or YAML config files might be added to `/etc/traefik/conf.d/` (a traefik restart will be required).


