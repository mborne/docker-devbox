# Note to forward localhost to traefik


```bash
# https://traefik.localhost:8443
ssh -N -L 8443:localhost:443 vagrant@vagrantbox-1
```

```bash
# https://traefik.localhost
sudo ssh -i $HOME/.ssh/.id_rsa -N -L 443:localhost:443 vagrant@vagrantbox-1
```

