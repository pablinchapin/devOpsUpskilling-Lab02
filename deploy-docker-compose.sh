#!/bin/bash

######################################################################
## Create a docker compose YAML file to build the an infrastructure using a website container and mysql container in a different network than the previous exercise
## bash file to deploy this docker compose infrastructure
######################################################################

DATE=`date +%Y.%m.%d.%H.%M`
FILE_NAME=$0
LOCAL_PATH=`readlink -f "${BASH_SOURCE:-$FILE_NAME}"`
DIR_PATH=`dirname $LOCAL_PATH`
PROJECT_NAME=lab02

# display information 
echo $DATE
echo "File: $FILE_NAME"
echo "Absolute path: $LOCAL_PATH"
echo "Directory path: $DIR_PATH"


# deploying docker compose infrastructure
echo "deploying docker compose infrastructure for project $PROJECT_NAME ..."
docker compose -p $PROJECT_NAME up -d