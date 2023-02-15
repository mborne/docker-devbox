# Vault

Container running [HashiCorp vault](https://www.vaultproject.io/) for **DEV purpose**.

## Usage with docker

* Start vault : `docker compose up -d`

* Open https://vault.dev.localhost and configure vault

* Configure client and [perform some checks](https://learn.hashicorp.com/vault?track=getting-started#getting-started) :

```bash
export VAULT_ADDR=https://vault.dev.localhost

# -- check server status
vault status

# -- login to vault (token)
vault login
# vault login -method=userpass username=mborne

# -- store secret
vault kv put cubbyhole/db-secret username=postgis password=ChangeIt

# -- retrieve secret
vault kv get cubbyhole/db-secret
vault kv get -field=data -format=json cubbyhole/db-secret
vault kv get -field=data -format=yaml cubbyhole/db-secret

# -- delete secret
vault kv delete cubbyhole/db-secret
```

