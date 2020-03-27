#!/bin/sh
# Run the OpenDJ server
# The idea is to consolidate all of the writable DJ directories to
# a single instance directory root, and update DJ's instance.loc file to point to that root
# This allows us to to mount a data volume on that root which  gives us
# persistence across restarts of OpenDJ.
# For Docker - mount a data volume on /opt/forgerock/opendj/data
# For Kubernetes mount a PV


cd /opt/forgerock/$djNode/opendj


# Instance dir does not exist? Then we need to run setup
  if [ ! -d ./data/config ] ; then
	  echo "Instance data Directory is empty. Creating new DJ instance"

	  BOOTSTRAP=${BOOTSTRAP:-/opt/forgerock/opendj/Bootstrap/setup.sh}
	  echo "Running $BOOTSTRAP"
	  sh "${BOOTSTRAP}"

	   # Check if DJ_MASTER_SERVER var is set. If it is - replicate to that server
	  # if [ ! -z ${DJ_MASTER_SERVER+x} ];  then
		#  /opt/forgerock/opendj/bootstrap/replicate.sh $DJ_MASTER_SERVER
	  # fi
  fi

  if [  -f /opt/forgerock/$djNode/opendj/bak/cfgStore/backup.info ]; then
		echo "nested if"
		
		if [ $restore = "1" ]; 
		 then
		 
		cd /opt/forgerock/$djNode/opendj/bak/cfgStore
		result=$(ls -t1 |  head -n 1)
		SUBSTRING=$(echo $result| cut -d'-' -f 3)
		
		cd /opt/forgerock/$djNode/opendj
		
		echo "backup ID $SUBSTRING in progress"
		
		/opt/forgerock/$djNode/opendj/bin/restore --offline --backupID $SUBSTRING --backupDirectory /opt/forgerock/$djNode/opendj/bak/adminRoot
		#/opt/forgerock/$djNode/opendj/bin/restore --offline --backupID $SUBSTRING --backupDirectory /opt/forgerock/$djNode/opendj/bak/ads-truststore
		/opt/forgerock/$djNode/opendj/bin/restore --offline --backupID $SUBSTRING --backupDirectory /opt/forgerock/$djNode/opendj/bak/cfgStore
		#/opt/forgerock/$djNode/opendj/bin/restore --offline --backupID $SUBSTRING --backupDirectory /opt/forgerock/$djNode/opendj/bak/monitorUser
		/opt/forgerock/$djNode/opendj/bin/restore --offline --backupID $SUBSTRING --backupDirectory /opt/forgerock/$djNode/opendj/bak/rootUser
		/opt/forgerock/$djNode/opendj/bin/restore --offline --backupID $SUBSTRING --backupDirectory /opt/forgerock/$djNode/opendj/bak/schema
		/opt/forgerock/$djNode/opendj/bin/restore --offline --backupID $SUBSTRING --backupDirectory /opt/forgerock/$djNode/opendj/bak/tasks
		fi
 fi



if (bin/status -n | grep Started) ; then
   echo "OpenDJ is started"
   # We cant exit because we are pid 1
   while true; do sleep 100000; done
fi


echo "Starting OpenDJ"
#
sh ./bin/start-ds 

wait_for_node()
{
	
	while true
	do 
		if (bin/status --offline -n | grep Started) ; then
		
		   if [ ! -d ./config ] ; then
				sh /opt/forgerock/$djNode/opendj/Bootstrap/$node/postsetup.sh
				sleep 1000000
		   fi
		fi 
	done
}
wait_for_node

