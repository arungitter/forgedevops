#!/bin/sh
# Default setup script

echo "Post Setup in progress"

/opt/forgerock/$djNode/opendj/bin/backup  --hostname $host  --port $adminport  --bindDN "cn=DirectoryManager"  --bindPassword $rootpass --backUpAll  --backupDirectory /opt/forgerock/$djNode/opendj/bak --backUpAll --recurringTask "$cron" --completionNotify $email --errorNotify $email  --trustAll

/opt/forgerock/$djNode/opendj/bin/ldapmodify --hostname $host --port $ldapPort --bindDN "cn=DirectoryManager" --bindPassword $rootpass --control RelaxRules:true --numConnections 4 /opt/forgerock/$djNode/opendj/bak/vcustomschema.ldif
.ldif

/opt/forgerock/$djNode/opendj/bin/dsconfig set-password-policy-prop  --policy-name Default\ Password\ Policy \    --set allow-pre-encoded-passwords:true     --hostname $host   --port $adminport    --bindDn "cn=DirectoryManager"    --bindPassword $adminport     --trustAll    --no-prompt


/opt/forgerock/$djNode/opendj/bin/ldapmodify --hostname $host --port $ldapPort --bindDN "cn=DirectoryManager" --bindPassword $adminport --control RelaxRules:true --numConnections 4 /opt/forgerock/$djNode/opendj/bak/ful.ldif


