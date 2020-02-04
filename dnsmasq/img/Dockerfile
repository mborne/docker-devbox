FROM debian:stretch

# enable log-queries
ENV DEBUG=0
# forward DNS resolution
ENV DNS_SERVERS="1.1.1.1 1.0.0.1"

RUN apt-get update && \
  apt-get install --no-install-recommends -y dnsmasq && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 53
ENTRYPOINT ["/docker-entrypoint.sh"]
