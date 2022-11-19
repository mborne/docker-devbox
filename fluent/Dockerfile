FROM fluent/fluentd:v1.12.0-debian-1.0
USER root

RUN apt-get update && apt-get install -y libsystemd-dev make gcc g++ libc6-dev ruby-dev

RUN ["gem", "install", "fluent-plugin-opensearch", "--no-document"]
RUN ["gem", "install", "fluent-plugin-systemd", "--no-document", "-v","1.0.2"]

RUN mkdir -p /data && chmod 777 /data
VOLUME /data

#USER fluent
