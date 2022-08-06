# Note to forward localhost to traefik

To access `https://*.dev.localhost` URLs with a **remote host** running K3S :

## With redir

```bash
# sudo apt-get install redir
sudo redir --lport=443 --laddr=127.0.0.1 --caddr=192.168.50.201 --cport=443
```

Or with something like `/etc/systemd/system/vagrantbox-redir-https.service` :

```ini
[Unit]
Description=vagrantbox-redir-https
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/redir --lport=443 --laddr=127.0.0.1 --caddr=192.168.50.201 --cport=443
PIDFile=/run/vagrantbox-redir-https.pid

[Install]
WantedBy=multi-user.target
```

## With SSH

```bash
# https://traefik.localhost:8443
ssh -N -L 8443:localhost:443 vagrant@vagrantbox-1
```

```bash
# https://traefik.localhost
sudo ssh -i $HOME/.ssh/.id_rsa -N -L 443:localhost:443 vagrant@vagrantbox-1
```

