FROM java:8

MAINTAINER arun.verma@valvoline.com

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV AMSTER_HOME /opt/forgerock 

RUN apt-get install -y curl
RUN ls -l

WORKDIR $AMSTER_HOME/

ADD amster/amster.zip $AMSTER_HOME/
RUN unzip $AMSTER_HOME/amster.zip -d $AMSTER_HOME/amster
WORKDIR $AMSTER_HOME/

COPY amster/docker-entrypoint.sh amster/docker-entrypoint.sh
RUN chmod +x amster/docker-entrypoint.sh
COPY amster/pre-install-scripts amster/pre-install-scripts
COPY amster/amster-install.sh amster/amster-install.sh
COPY amster/scripts amster/scripts
COPY amster/post-install-scripts amster/post-install-scripts

WORKDIR $AMSTER_HOME/amster
RUN ls -l

ENTRYPOINT ["bash", "-x", "docker-entrypoint.sh"]
CMD ["configure"]
