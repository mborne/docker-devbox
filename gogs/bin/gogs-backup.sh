#!/bin/bash

# create target directory
mkdir -p /backup/gogs

# fix permissions
chown -R git:users /backup/gogs

# create backup
su -c "/app/gogs/gogs backup --target=/backup/gogs" -s /bin/sh - git

# keep only 3 backups
ls -1t /backup/gogs/* | tail -n +4 | xargs /bin/rm -f

# display existing backups
ls -1t /backup/gogs/*
