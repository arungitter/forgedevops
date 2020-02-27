FROM java:8

MAINTAINER arun.verma@valvoline.com

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

ARG djNode
RUN echo $djNode

ENV djNode $djNode
ENV dj_home=/opt/forgerock

WORKDIR $dj_home/
RUN ls -l
ADD DS/DS-6.5.2.zip  $djNode/
WORKDIR $dj_home/$djNode/

 
WORKDIR $dj_home/
RUN unzip $djNode/DS-6.5.2.zip -d $djNode/


ADD DS/Bootstrap/ $djNode/opendj/Bootstrap/
RUN ls -l 


EXPOSE 1389 1636 4444 8989 1388 1637 4443 8988

ADD DS/run.sh $djNode/opendj/run.sh

WORKDIR $dj_home/$djNode/
CMD ["opendj/run.sh"]
