#!/bin/bash

# Please replace ContainerID with docker container id, it will be like f80d57c69b40, 
# or you can see using the docker ps -a command

# First need to crate a dumps folder on docker container
docker exec ContainerID mkdir -p dumps

# Docker Dumps Command for backup the database
docker exec ContainerID sh -c 'mysqldump -uUSER -pPASSWORD db_name > /dumps/db_name.sql'

# Move dump file to the host machine
docker cp ContainerID:/dumps/brur_sms_db.sql ../mysql-backup/brur_sms_db.sql
