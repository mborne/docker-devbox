# gogs

Docker container running gogs official image extended with backup/restore facilities.

## Usage

* Build : `docker-compose build --pull`
* Start : `docker-compose up -d`
* Open http://gogs.localhost
* Create an account (the first one will be an administrator)

## Backup

```bash
docker-compose exec gogs gogs-backup.sh
```

## Restore backup

```bash
# Copy local backup to image
docker cp gogs-backup-20200313230018.zip gogs:/backup/gogs/.
# Stop gogs
docker-compose down
# Remove gogs-data
docker volume rm gogs-data
# Restore backup
docker-compose run --rm gogs gogs-restore.sh /backup/gogs/gogs-backup-20200313230018.zip
# Start gogs
docker-compose up -d
```

## CLI management

```bash
# connect to container
docker-compose exec gogs /bin/bash
su git
./gogs --help
```
