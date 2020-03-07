FROM openjdk:8-alpine

RUN mkdir /opt/forgerock \
	&& adduser --disabled-password fruserd \
	&& chown fruserd /opt/forgerock

USER fruserd
WORKDIR /opt/forgerock

ADD --chown=fruserd IDM/IDM-6.5.0.3.zip .
RUN unzip -q IDM-6.5.0.3.zip && rm IDM-6.5.0.3.zip 

EXPOSE 8280 8243
WORKDIR /opt/forgerock/openidm
RUN ls -l
ENTRYPOINT ["sleep", "1000000"]
