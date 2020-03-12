FROM openjdk:8-jre-alpine
MAINTAINER Arun Verma <arun.verma@valvoline.com>

ENV TOMCAT_MAJOR 9
ENV TOMCAT_VERSION 9.0.31

#ENV TOMCAT_TGZ_URL http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
#ENV KEYSTORE /opt/forgerock/tomcat/conf/keystore
#ENV KEYPASS changeit
#ENV KEY_DNAME "cn=Tomcat, ou=Docker, o=cloud, c=internet"

ADD AM/apache-tomcat-9.0.31.tar.gz /opt/forgerock/
WORKDIR /opt/forgerock
RUN ls -l
RUN \
#    mv apache-tomcat-9.0.31.tar.gz tomcat.tar.gz && \
#    tar xzf tomcat.tar.gz && \
    mv apache-tomcat-9.0.31 tomcat && \
    rm -f tomcat/bin/*.bat tomcat/bin/*.gz tomcat/temp/* tomcat.tar.gz tomcat/[A-Z]* && \
    rm -rf tomcat/webapps/*

ADD AM/start_override.sh /opt/forgerock/tomcat/bin/
ADD AM/server.xml /opt/forgerock/tomcat/conf/
ADD AM/auth.war /opt/forgerock/tomcat/webapps/
WORKDIR /opt/forgerock/tomcat
EXPOSE 8009 8180 8143
CMD [ "bin/start_override.sh", "bin/catalina.sh", "run" ]