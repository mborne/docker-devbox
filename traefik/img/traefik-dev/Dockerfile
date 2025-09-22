FROM traefik:v3.5.2

RUN mkdir -p /etc/traefik
COPY config /etc/traefik/.
VOLUME /etc/traefik

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

