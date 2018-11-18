#!/bin/bash

if [ -z "$1" ];
then
    echo "Usage : gogs-restore.sh <path-to-zip>"
    exit 1
fi

if [ ! -e "$1" ];
then
    echo "$1 not found!"
    exit 1
fi


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

USER=git /app/gogs/gogs restore -t tmp --from $1

