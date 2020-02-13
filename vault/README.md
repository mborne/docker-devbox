# vault

Docker container to test [archicorp vault](https://hub.docker.com/_/vault).

## Usage

* Start vault : `docker-compose up -d`

* Open http://vault.localhost and configure vault

* Configure client and perform some checks (see https://learn.hashicorp.com/vault?track=getting-started#getting-started)

```bash
export VAULT_ADDR=http://vault.localhost

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

