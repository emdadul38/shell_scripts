#!/bin/bash

# Please replace ContainerID with docker container id, it will be like f80d57c69b40, 
# or you can see using the docker ps -a command

# Docker Dumps Command
docker exec ContainerID sh -c 'mysqldump -uUSER -pPASSWORD db_name > /dumps/db_name.sql'

# Move dump file to the host machine
docker cp ContainerID:/dumps/brur_sms_db.sql ../mysql-backup/brur_sms_db.sql
