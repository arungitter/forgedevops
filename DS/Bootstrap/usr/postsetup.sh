#!/bin/sh
# Default setup script

echo "Post Setup in progress"

/opt/forgerock/$djNode/opendj/bin/backup  --hostname $host  --port $adminport  --bindDN "cn=DirectoryManager"  --bindPassword $rootpass --backUpAll  --backupDirectory /opt/forgerock/$djNode/opendj/bak --backUpAll --recurringTask "$cron" --completionNotify $email --errorNotify $email  --trustAll


