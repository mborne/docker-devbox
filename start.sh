#!/bin/bash

echo "-- Ensure that docker can run a simple image..."
docker run --rm hello-world &> /dev/zero || {
    echo "KO : fail to execute 'docker run --rm hello-world'";
    exit 1;
}
echo "OK"

echo "-- Ensure that traefik is started..."
if [ -z "$(docker ps -a | grep traefik)" ];
then
    echo "start traefik..."
    cd traefik
    docker-compose up -d || {
        echo "KO : fail to start traefik!"
        exit 1
    }
    cd ..
fi
echo "OK"

echo "(see whoami/README.md to get started with traefik)"
