FROM fluent/fluentd:v1.12.0-debian-1.0
USER root
RUN ["gem", "install", "fluent-plugin-opensearch", "--no-document"]

RUN mkdir -p /data && chmod 777 /data
VOLUME /data

#USER fluent
