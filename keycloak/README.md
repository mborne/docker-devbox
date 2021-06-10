# keycloak

## Usage

* Create database

```bash
createdb keycloak
```

* Start keycloak : `sudo docker-compose up -d`

* Avoid "HTTPS required" :

```bash
psql -d keycloak -c "update REALM set ssl_required='NONE' where id = 'master'";
sudo docker-compose restart
```

* Create first admin user :

```bash
sudo docker-compose exec keycloak /opt/jboss/keycloak/bin/add-user-keycloak.sh \
  -r master -u admin -p admin

# restart server to load user
sudo docker-compose restart
```

## Notes

### OpenID connect

* See http://keycloak.localhost/auth/realms/master/.well-known/openid-configuration

### Custom theme

* See https://www.baeldung.com/spring-keycloak-custom-themes
* Within docker :
  * See env vars KEYCLOAK_WELCOME_THEME and KEYCLOAK_DEFAULT_THEME
  * Inspect `/opt/jboss/keycloak/themes/`
* `custom-theme` defined for the welcome app (internationalization is not available?)

### Admin API

```bash
KEYCLOAK_USER=admin
KEYCLOAK_PASSWORD=admin

# get token
TOKEN=$(curl -s -X POST -H 'Content-Type: application/x-www-form-urlencoded' --data "client_id=admin-cli&grant_type=password&username=${KEYCLOAK_USER}&password=${KEYCLOAK_PASSWORD}" http://keycloak.localhost/auth/realms/master/protocol/openid-connect/token)

# extract access token (expires after 60 seconds)
ACCESS_TOKEN=$(echo $TOKEN | jq -r '.access_token')

# list realms
curl -sS -X GET 'http://keycloak.localhost/auth/admin/realms/master/users' \
  -H "Accept: application/json" \
  -H "Authorization: bearer ${ACCESS_TOKEN}" | jq
```
