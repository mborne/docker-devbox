# openldap

## Description

Docker containers running openldap and phpldapadmin

## Usage

* Start openldap

```bash
LDAP_DOMAIN=my-domain.com LDAP_ADMIN_PASSWORD=my-password docker-compose up -d
```

* Open ldapadmin : http://ldapadmin.localhost

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
ldapsearch -H ldap://openldap.devbox -D "cn=admin,dc=my-domain,dc=com" -b "dc=my-domain,dc=com" -w "my-password" -s sub "(objectClass=*)"
```

## Resources

See https://github.com/osixia/docker-openldap
