# Some notes about docker

## Port mapping

Most service ports are only exposed on `127.0.0.1` as I noted that docker overwrites `iptables`/[UFW](https://help.ubuntu.com/community/UFW) rules.

## Traefik as a service

To ease IP filtering and avoid the requirement for the containers to share the traefik network, it is easier to install traefik as a service.

See [mborne/ansible-traefik](https://github.com/mborne/ansible-traefik#ansible-traefik) which illustrated deployment as a systemd service.
