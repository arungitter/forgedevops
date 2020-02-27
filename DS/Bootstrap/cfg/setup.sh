#!/usr/bin/env bash
# Default setup script

echo "Setting up default OpenDJ instance"

# If any optional LDIF files are present load them

#/opt/opendj/setup --cli -p 1389 --ldapsPort 636 --enableStartTLS --generateSelfSignedCertificate \
  #--baseDN $BASE_DN -h localhost --rootUserPassword "$PASSWORD" \
 # --acceptLicense --no-prompt --sampleData 2

/opt/forgerock/opendj_cfg/opendj/setup  directory-server  --rootUserDN cn=DirectoryManager  --rootUserPassword Inside@123  --monitorUserPassword Inside@123  --hostname nausawsodj603.corp.valvoline.com  --ldapPort $ldapPort  --doNotStart --ldapsPort $ldapsPort  --httpsPort $httpsPort  --adminConnectorPort $adminConnectorPort  --productionMode  --profile am-config  --set am-config/amConfigAdminPassword:Inside@123  --acceptLicense 
 
#--addBaseEntry

#
##  --addBaseEntry --doNotStart



# does not work - becaue these are add/modify/update ops - not schema files

#if [ -d /opt/opendj/bootstrap/ldif ]; then
#   cd /opt/opendj/bootstrap/ldif
#   for file in *.ldif;  do
#      echo "adding $file"
#       cp  $file "/opt/opendj/data/config/schema/99-${file}"
#   done
#
#ls -lR /opt/opendj/data
#
#fi



#LDIF=""
#if [ -d /opt/opendj/bootstrap/ldif ]; then
#  for file in /opt/opendj/bootstrap/ldif/*;  do
#      #LDIF="${LDIF} -l $file "
#      /opt/opendj/bin/ldapmodify -D "cn=Directory Manager" -h localhost -p 389 -w $PASSWORD -f $file
#  done

   #cat /opt/opendj/bootstrap/ldif/*.ldif >/tmp/in.ldif

   # /opt/opendj/bin/import-ldif -b $BASE_DN -n userRoot -p 4444 -w $PASSWORD -l /tmp/in.ldif
#fi
