FROM tomcat:8.5-jdk11

ARG version=2.21.0

ENV GEOSERVER_DATA_DIR=/var/geoserver
ENV geoserver.xframe.shouldSetPolicy=false

WORKDIR /tmp

RUN apt-get update \
 && apt-get install -y wget unzip \
 && wget --progress=bar:force -O geoserver-war.zip http://sourceforge.net/projects/geoserver/files/GeoServer/${version}/geoserver-${version}-war.zip \
 && unzip geoserver-war.zip \
 && rm -rf /usr/local/tomcat/webapps/ROOT \
 && unzip -d /usr/local/tomcat/webapps/ROOT geoserver.war \
 && rm -rf geoserver* \
 && rm -rf /var/lib/apt/lists/*

VOLUME /var/geoserver
WORKDIR /var/geoserver
