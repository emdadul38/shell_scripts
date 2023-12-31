#!/bin/bash

# Database information
DB_USER="your_db_username"
DB_PASS="your_db_password"
DB_NAME="your_db_name"
containerID="f80d57c69b40"

# Please replace ContainerID with docker container id, it will be like f80d57c69b40, 
# or you can see using the docker ps -a command

# First need to crate a dumps folder on docker container
docker exec $containerID mkdir -p dumps

# Docker Dumps Command for backup the database
docker exec $containerID sh -c "mysqldump -u$DB_USER -p$DB_PASS $DB_NAME > /dumps/$DB_NAME.sql"

# Move dump file to the host machine
docker cp $containerID:/dumps/$DB_NAME.sql ../mysql-backup/$DB_NAME.sql
