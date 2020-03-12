#!/bin/sh

executable="${1}"
shift
command="${executable} $*"

if [ ! -z "${TOMCAT_HOST_OVERRIDE}" -a -d "${TOMCAT_HOST_OVERRIDE}" ]; then
	echo "Overriding default Tomcat installation using files from ${TOMCAT_HOST_OVERRIDE}:"
	find "${TOMCAT_HOST_OVERRIDE}" -type f
	cp -a "${TOMCAT_HOST_OVERRIDE}"/* /opt/forgerock/tomcat/
fi

[ -z "${TOMCAT_UID}" ] && TOMCAT_UID=0
[ -z "${TOMCAT_GID}" ] && TOMCAT_GID=0

[ ${TOMCAT_GID} -ne 0 ] && (echo "Creating tomcat group(${TOMCAT_GID})" && addgroup -g ${TOMCAT_GID} tomcat)
[ ${TOMCAT_UID} -ne 0 ] && (echo "Creating tomcat user(${TOMCAT_UID})" && adduser -D -H -u ${TOMCAT_UID} -G tomcat -k /bin/sh tomcat)

#if [ ! -f ${KEYSTORE} ]; then
#    keytool -genkey -alias tomcat -keyalg RSA \
#	-dname "${KEY_DNAME}" \
#	-validity 365 -keypass ${KEYPASS} -storepass ${KEYPASS} \
#	-keystore ${KEYSTORE}
#fi

if [ ${TOMCAT_UID} -ne 0 -o ${TOMCAT_GID} -ne 0 ]; then
	chown -R ${TOMCAT_UID}:${TOMCAT_GID} /opt/forgerock/tomcat
	echo "#!/bin/sh" > bin/start_wrapper.sh
	echo "exec ${command}" >> bin/start_wrapper.sh
	chmod a+rx bin/start_wrapper.sh
	su -c bin/start_wrapper.sh -s /bin/sh tomcat
else
	${command}
fi
