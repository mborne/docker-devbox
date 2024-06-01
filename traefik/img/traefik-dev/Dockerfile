FROM traefik:v2.11

RUN mkdir -p /etc/traefik
COPY config /etc/traefik/.
VOLUME /etc/traefik

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

