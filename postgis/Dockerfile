FROM postgres:10.4

RUN apt-get update \
 && apt-get install -y postgresql-10-postgis-2.4 \
 && rm -rf /var/lib/apt/lists/*

COPY set-config.sh /docker-entrypoint-initdb.d/set-config.sh
