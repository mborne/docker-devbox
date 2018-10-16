# gogs

## Description

Docker container with gogs

## Usage

* Start gogs : `docker-compose up -d`
* Open http://gogs.localhost
* Create an account (the first one will be an administrator)

## Backup

On host : 

```bash
bash backup.sh
```

## Restore

```bash
docker-compose down
docker-compose run --rm gogs /bin/bash
```

Then, in container :

```bash
cd /data

mkdir -p data
rm -fR data/*

rm -fR gogs.bak
rm -fR tmp
mkdir -p tmp
mkdir -p tmp/gogs-backup
mkdir -p tmp/gogs-backup/data/
mkdir -p tmp/gogs-backup/data/attachments
mkdir -p tmp/gogs-backup/data/avatars

USER=git /app/gogs/gogs restore -t tmp --from /backup/gogs-backup-1538373444.zip
```

