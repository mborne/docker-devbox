#!/bin/bash

#---------------------------------------
# generate config according to ENV
#---------------------------------------
echo "no-resolv" > /etc/dnsmasq.conf
if [ "$DEBUG" -eq "1" ];
then
    echo "log-queries" >> /etc/dnsmasq.conf
fi

echo "strict-order" >> /etc/dnsmasq.conf

# forward resolution for containers
echo "server=/devbox/127.0.0.11" >> /etc/dnsmasq.conf

# forward resolution for internet domains
for DNS_SERVER in $DNS_SERVERS;
do
    echo "server=${DNS_SERVER}" >> /etc/dnsmasq.conf
done

echo "conf-dir=/etc/dnsmasq.d" >> /etc/dnsmasq.conf

#---------------------------------------
# start dnsmasq
#---------------------------------------
dnsmasq -u root --no-daemon
