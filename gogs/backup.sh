#!/bin/bash

# fix permissions
docker-compose exec gogs /bin/bash -c 'chown -R git:users /backup'
# create backup
docker-compose exec gogs su -c "/app/gogs/gogs backup --target=/backup" -s /bin/sh - git
# keep only 3 backups
docker-compose exec gogs /bin/bash -c 'ls -1t /backup/* | tail -n +4 | xargs /bin/rm -f'
docker-compose exec gogs /bin/bash -c 'ls -1t /backup/*'

