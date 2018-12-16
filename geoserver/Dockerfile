FROM tomcat:8.5-slim

ARG version=2.14.1

ENV GEOSERVER_DATA_DIR=/var/geoserver

WORKDIR /tmp

RUN apt-get update \
 && apt-get install -y wget \
 && wget --progress=bar:force -O geoserver-war.zip http://sourceforge.net/projects/geoserver/files/GeoServer/${version}/geoserver-${version}-war.zip \
 && unzip geoserver-war.zip \
 && rm -rf /usr/local/tomcat/webapps/ROOT \
 && unzip -d /usr/local/tomcat/webapps/ROOT geoserver.war \
 && rm -rf geoserver* \
 && rm -rf /var/lib/apt/lists/*

VOLUME /var/geoserver
WORKDIR /var/geoserver
