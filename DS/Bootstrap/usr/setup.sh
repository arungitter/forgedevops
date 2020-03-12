#!/bin/sh
# Default setup script

echo "Setting up default OpenDJ instance"

# If any optional LDIF files are present load them

#/opt/opendj/setup --cli -p 1389 --ldapsPort 636 --enableStartTLS --generateSelfSignedCertificate \
  #--baseDN $BASE_DN -h localhost --rootUserPassword "$PASSWORD" \
 # --acceptLicense --no-prompt --sampleData 2

/opt/forgerock/opendj_usr/opendj/setup directory-server --rootUserDn cn=DirectoryManager --rootUserPassword $rootpass   --monitorUserDn uid=Monitor --monitorUserPassword $monitorpass --hostname $host    --doNotStart    --adminConnectorPort $adminport    --ldapPort $ldapPort   --enableStartTls  --ldapsPort $ldapsPort  --httpsPort $httpsPort  --addBaseEntry  --baseDn dc=valvoline,dc=com --acceptLicense



