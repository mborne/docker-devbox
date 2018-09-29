#!/bin/bash

docker-compose exec gogs su -c "/app/gogs/gogs backup --target=/data/backup" -s /bin/sh - git
docker-compose exec gogs /bin/bash -c 'ls -1tr /data/backup/* | tail -n +5 | xargs /bin/rm -f'
docker-compose exec gogs /bin/bash -c 'ls -1tr /data/backup/*'
