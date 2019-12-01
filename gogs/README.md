# gogs

## Description

Docker container with gogs official image extended with backup/restore facilities.

## Usage

* Start gogs : `docker-compose up -d`
* Open http://gogs.localhost
* Create an account (the first one will be an administrator)

## Backup

On host :

```bash
docker-compose exec gogs gogs-backup.sh
```

## Restore

```bash
docker-compose down
docker volume rm gogs-data
docker-compose run --rm gogs gogs-restore.sh /backup/gogs/gogs-backup-1542542824.zip
docker-compose up -d
```

