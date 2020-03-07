FROM openjdk:8-alpine

MAINTAINER arun.verma@valvoline.com

#ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV AMSTER_HOME /opt/forgerock 

RUN apk add curl
RUN ls -l

RUN mkdir amster
WORKDIR $AMSTER_HOME/amster

ADD amster/amster-6.5.2.2.zip ./
RUN unzip amster-6.5.2.2.zip -d ./
RUN ls -l


COPY amster/docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
COPY amster/pre-install-scripts pre-install-scripts
COPY amster/amster-install.sh amster-install.sh
COPY amster/scripts scripts
COPY amster/post-install-scripts post-install-scripts

#ENTRYPOINT ["ls", "-l"]
#ENTRYPOINT ["sleep", "1000000"]
#ENTRYPOINT ["bash", "-x", "docker-entrypoint.sh"]
#CMD ["configure"]

ENTRYPOINT ./docker-entrypoint.sh configure