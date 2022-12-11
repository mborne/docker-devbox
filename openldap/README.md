# [OpenLDAP](https://www.openldap.org/)

Containers running [osixia/openldap](https://github.com/osixia/docker-openldap#osixiaopenldap) and [osixia/docker-phpLDAPadmin](https://github.com/osixia/docker-phpLDAPadmin).

## Usage with docker

* Start openldap

```bash
LDAP_DOMAIN=my-domain.com LDAP_ADMIN_PASSWORD=my-password docker compose up -d
```

* Open ldapadmin : https://ldapadmin.dev.localhost

* Login with admin account
    * Login DN : `cn=admin,dc=my-domain,dc=com`
    * Password : `my-password`

* Create groups and user accounts

For example :

```
ou=groups,dc=my-domain,dc=com
cn=admins,ou=groups,dc=my-domain,dc=com
cn=users,ou=groups,dc=my-domain,dc=com

ou=people,dc=my-domain,dc=com
cn=somebody,ou=people,dc=my-domain,dc=com
...
```

```bash
ldapsearch -H ldap://localhost:389 -D "cn=admin,dc=my-domain,dc=com" -b "dc=my-domain,dc=com" -w "my-password" -s sub "(objectClass=*)"
```

## Resources

See https://github.com/osixia/docker-openldap
