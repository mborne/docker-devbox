# Notes about admin API

```bash
KEYCLOAK_USER=admin
KEYCLOAK_PASSWORD=ChangeIt

# get token
TOKEN=$(curl -s -X POST -H 'Content-Type: application/x-www-form-urlencoded' --data "client_id=admin-cli&grant_type=password&username=${KEYCLOAK_USER}&password=${KEYCLOAK_PASSWORD}" https://keycloak.dev.localhost/realms/master/protocol/openid-connect/token)

# extract access token (expires after 60 seconds)
ACCESS_TOKEN=$(echo $TOKEN | jq -r '.access_token')

# list realms
curl -sS -X GET 'https://keycloak.dev.localhost/admin/realms/master/users' \
  -H "Accept: application/json" \
  -H "Authorization: bearer ${ACCESS_TOKEN}" | jq
```
