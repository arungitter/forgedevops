#!/bin/sh
# Default setup script

echo "Setting up default OpenDJ instance"

# If any optional LDIF files are present load them

#/opt/opendj/setup --cli -p 1389 --ldapsPort 636 --enableStartTLS --generateSelfSignedCertificate \
  #--baseDN $BASE_DN -h localhost --rootUserPassword "$PASSWORD" \
 # --acceptLicense --no-prompt --sampleData 2

/opt/forgerock/opendj_usr/opendj/setup directory-server --rootUserDn cn=DirectoryManager --rootUserPassword Inside@123   --monitorUserDn uid=Monitor --monitorUserPassword Inside@123 --hostname $host    --doNotStart    --adminConnectorPort $adminConnectorPort    --ldapPort $ldapPort   --enableStartTls  --ldapsPort $ldapsPort  --httpsPort $httpsPort  --addBaseEntry  --baseDn dc=valvoline,dc=com --acceptLicense


/opt/forgerock/opendj_usr/opendj/bin/backup  --hostname nausawsodj603.corp.valvoline.com  --port 4444  --bindDN "cn=DirectoryManager"  --bindPassword "Inside@123" --backUpAll  --backupDirectory /opt/forgerock/OpenDJ_USR/opendj/bak --backUpAll --recurringTask "00 02 * * *" --completionNotify arun.verma@valvoline.com --errorNotify arun.verma@valvoline.com  --trustAll

# ./ldapmodify --hostname nausawsodj601.corp.valvoline.com --port 1388 -D "cn=DirectoryManager" -w Inside@123 /opt/forgerock/opendj_usr/opendj/Bootstrap/usr/.ldif 

# ./import-ldif --port 4443 --hostname nausawsodj601.corp.valvoline.com --bindDN "cn=DirectoryManager" --bindPassword Inside@123 --includeBranch dc=valvoline,dc=com --backendID userRoot --ldifFile /opt/forgerock/opendj_usr/opendj/Bootstrap/usr/8-user.ldif --trustAll

 #--addBaseEntry

#
##  --addBaseEntry --doNotStart



# does not work - becaue these are add/modify/update ops - not schema files

# if [ -d /opt/forgerock/opendj_usr/opendj/Bootstrap/usr ]; then
   # cd /opt/forgerock/opendj_usr/opendj/Bootstrap/usr
   # mkdir /opt/forgerock/opendj_usr/opendj/config/schema
    # for file in *.ldif;  do
      # echo "adding $file"
       # cp  $file "/opt/forgerock/opendj_usr/opendj/config/schema/${file}"
   # done

# ls -lR /opt/forgerock/opendj_usr/opendj/data
# fi



# LDIF=""
# if [ -d /opt/forgerock/opendj_usr/opendj/Bootstrap/usr ]; then
  # for file in /opt/forgerock/opendj_usr/opendj/Bootstrap/usr/9*;  do
      # LDIF="${LDIF} -l $file "
      # /opt/forgerock/opendj_usr/opendj/bin/ldapmodify -D -h nausawsodj601.corp.valvoline.com "cn=DirectoryManager" -p $ldapPort -w "Inside@123" -f $file
  # done

  # # cat /opt/forgerock/opendj_usr/opendj/Bootstrap/ldif/*.ldif >/tmp/in.ldif

 # #   /opt/forgerock/opendj_usr/opendj/bin/import-ldif -b $BASE_DN -n userRoot -p 4444 -w $PASSWORD -l /tmp/in.ldif
# fi

# LDIF=""
# if [ -d /opt/forgerock/opendj_usr/opendj/Bootstrap/usr ]; then
  # for file in /opt/forgerock/opendj_usr/opendj/Bootstrap/usr/8*;  do
      # LDIF="${LDIF} -l $file "
      # /opt/forgerock/opendj_usr/opendj/bin/import-ldif --includeBranch "dc=valvoline,dc=com" --backendID userRoot --ldifFile $file -–offline
  # done

  # # cat /opt/forgerock/opendj_usr/opendj/Bootstrap/ldif/*.ldif >/tmp/in.ldif

 # #   /opt/forgerock/opendj_usr/opendj/bin/import-ldif -b $BASE_DN -n userRoot -p 4444 -w $PASSWORD -l /tmp/in.ldif
# fi


