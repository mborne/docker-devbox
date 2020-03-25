#!/bin/bash

echo "-- Ensure that docker can run a simple image..."
docker run --rm hello-world &> /dev/zero || {
    echo "KO : fail to execute 'docker run --rm hello-world'";
    exit 1;
}
echo "OK"

echo "-- Ensure that network 'devbox' is created..."
if [ -z "$(docker network ls | grep devbox)" ];
then
    echo "create 'devbox' network with subnet=192.168.150.0/24"
    docker network create -d bridge \
        --gateway 192.168.150.1 \
        --ip-range 192.168.150.128/25 \
        --subnet 192.168.150.0/24 \
        devbox > /dev/zero || {
            echo "KO : fail to create 'devbox' network"
            exit 1;
        }
fi
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

echo "-- Ensure that dnsmasq is started..."
if [ -z "$(docker ps -a | grep dnsmasq)" ];
then
    echo "start dnsmasq..."
    cd dnsmasq
    docker-compose up -d || {
        echo "KO : fail to start dnsmasq!"
        exit 1
    }
    cd ..
fi
echo "OK"

echo "-- [OPTIONAL] Ping dnsmasq.devbox to ensure that host is configured to resolve DNS throw dnsmasq container..."
ping dnsmasq.devbox -c 1 || {
    echo "[OPTIONAL] KO : fail to ping dnsmasq.devbox, configure name resolution to use dnsmasq container :"
    docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dnsmasq
    exit 1;
}
