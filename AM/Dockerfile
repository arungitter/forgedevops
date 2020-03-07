FROM openjdk:8-alpine

MAINTAINER arun.verma@valvoline.com

#ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV AM_HOME /opt/forgerock 

#ARG shutdown_port

#ENV CATALINA_OPTS "-XX:MaxRAMPercentage=75.0 -Dcom.iplanet.services.stats.state=off -Djavax.net.ssl.trustStore=/var/run/secrets/truststore/cacerts -Djavax.net.ssl.trustStorePassword=changeit -D"

#RUN apt-get install -y curl


RUN mkdir openam
WORKDIR $AM_HOME/


ADD AM/apache-tomcat*  $AM_HOME/
RUN cp -R $AM_HOME/apache-tomcat* $AM_HOME/tomcat
RUN rm -R $AM_HOME/apache-tomcat*
WORKDIR $AM_HOME/tomcat
RUN ls -l
WORKDIR $AM_HOME/


RUN rm -fr tomcat/webapps/*
COPY AM/auth.war tomcat/webapps/auth.war

COPY AM/server.xml tomcat/conf/server.xml
COPY AM/run.sh tomcat/run.sh
RUN chmod +x tomcat/run.sh
WORKDIR $AM_HOME/tomcat/bin
RUN ls -l
WORKDIR $AM_HOME/
EXPOSE 8180 8143

WORKDIR $AM_HOME/
CMD ["tomcat/run.sh"]

#WORKDIR $AM_HOME/amster/
#ENTRYPOINT ["bash", "-x", "docker-entrypoint.sh"]

#CMD ["configure"]
