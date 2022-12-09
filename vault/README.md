# [Vault](https://www.vaultproject.io/)

Docker container to test [HashiCorp vault](https://hub.docker.com/_/vault).

## Usage with docker-compose

* Start vault : `docker-compose up -d`

* Open https://vault.dev.localhost and configure vault

* Configure client and [perform some checks](https://learn.hashicorp.com/vault?track=getting-started#getting-started) :

```bash
export VAULT_ADDR=https://vault.dev.localhost

# -- check server status
vault status

# -- login to vault
vault login $TOKEN
# vault login -method=userpass username=mborne

# -- store secret
vault kv put cubbyhole/hello foo=world

# -- retrieve secret
vault kv get cubbyhole/hello
vault kv get -field=data -format=json cubbyhole/hello
vault kv get -field=data -format=yaml cubbyhole/hello

# -- delete secret
vault kv delete cubbyhole/hello
```

