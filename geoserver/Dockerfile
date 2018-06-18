FROM tomcat:8.5

ARG version=2.13.1

ENV GEOSERVER_DATA_DIR=/usr/local/tomcat/webapps/geoserver/data

WORKDIR /tmp

RUN wget --progress=bar:force -O geoserver-war.zip http://sourceforge.net/projects/geoserver/files/GeoServer/${version}/geoserver-${version}-war.zip \
 && unzip geoserver-war.zip \
 && unzip -d /usr/local/tomcat/webapps/geoserver geoserver.war \
 && rm -rf geoserver*

VOLUME /usr/local/tomcat/webapps/geoserver/data
#/usr/local/tomcat
