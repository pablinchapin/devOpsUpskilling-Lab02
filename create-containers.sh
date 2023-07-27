#!/bin/bash

######################################################################
## Create a container image using a web server base that contains this website and can be used to publish it just matching the ports
## Using the Docker CLI, create a container using this image and mapping the port 8080 from the host.
## Using the Docker CLI, create a MYSQL container linked with the website container
## Try to validate the connection between the website container and the mysql container ← extra points
######################################################################

DATE=`date +%Y.%m.%d.%H.%M`
FILE_NAME=$0
LOCAL_PATH=`readlink -f "${BASH_SOURCE:-$FILE_NAME}"`
DIR_PATH=`dirname $LOCAL_PATH`
# directory names
MYSQL_PATH=$DIR_PATH/mysql
APP_PATH=$DIR_PATH/app
NGINX_PATH=$DIR_PATH/nginx
# image names
MYSQL_IMAGE_NAME=mysqldb
APP_IMAGE_NAME=app
NGINX_IMAGE_NAME=nginx
# network name
NETWORK_NAME=lab02net

# display information 
echo $DATE
echo "File: $FILE_NAME"
echo "Absolute path: $LOCAL_PATH"
echo "Directory path: $DIR_PATH"
# display directory names
echo "mysql path: $MYSQL_PATH"
echo "app path: $APP_PATH"
echo "nginx path: $NGINX_PATH"

# check network
NETWORK_ID=$(docker network ls -q -f name=$NETWORK_NAME)
if [[ -n "$NETWORK_ID" ]]; then
    # network already created 
    echo "network $NETWORK_NAME already created"
else
        echo "creating network $NETWORK_NAME"
        docker network create $NETWORK_NAME
fi


# change directory to /mysql
cd $MYSQL_PATH
#ls -la

MYSQL_IMAGE_ID=$(docker images -q $MYSQL_IMAGE_NAME)
if [[ -n "$MYSQL_IMAGE_ID" ]]; then
    # remove old mysql image if exists
    echo "removing $MYSQL_IMAGE_NAME with id $MYSQL_IMAGE_ID"
    docker rmi -f $MYSQL_IMAGE_ID
fi

# build mysql image
echo "building $MYSQL_IMAGE_NAME ..."
docker build -t $MYSQL_IMAGE_NAME .

MYSQL_CONTAINER_ID=$(docker ps -q -f name=$MYSQL_IMAGE_NAME)
if [[ -n "$MYSQL_CONTAINER_ID" ]]; then
    # remove mysql image if exists
    echo "removing $MYSQL_IMAGE_NAME container with id $MYSQL_CONTAINER_ID"
    docker container rm -f $MYSQL_CONTAINER_ID
fi
# deploy mysql image
echo "deploying $MYSQL_IMAGE_NAME ..."
docker run -d --network $NETWORK_NAME --name $MYSQL_IMAGE_NAME -p 3306:3306 $MYSQL_IMAGE_NAME


# change directory to /app
cd $APP_PATH
#ls -la

APP_IMAGE_ID=$(docker images -q $APP_IMAGE_NAME)
if [[ -n "$APP_IMAGE_ID" ]]; then
    # remove old app image if exists
    echo "removing $APP_IMAGE_NAME with id $APP_IMAGE_ID"
    docker rmi -f $APP_IMAGE_ID
fi

# build app image
echo "building $APP_IMAGE_NAME ..."
docker build -t $APP_IMAGE_NAME .

APP_CONTAINER_ID=$(docker ps -q -f name=$APP_IMAGE_NAME)
if [[ -n "$APP_CONTAINER_ID" ]]; then
    # remove mysql image if exists
    echo "removing $APP_IMAGE_NAME container with id $APP_CONTAINER_ID"
    docker container rm -f $APP_CONTAINER_ID
fi
# deploy app image
echo "deploying $APP_IMAGE_NAME ..."
docker run -d --network $NETWORK_NAME --name $APP_IMAGE_NAME -p 8081:5000 $APP_IMAGE_NAME



# change directory to /nginx
cd $NGINX_PATH
#ls -la

NGINX_IMAGE_ID=$(docker images -q $NGINX_IMAGE_NAME)
if [[ -n "$NGINX_IMAGE_ID" ]]; then
    # remove old nginx image if exists
    echo "removing $NGINX_IMAGE_NAME with id $NGINX_IMAGE_ID"
    docker rmi -f $NGINX_IMAGE_ID
fi

# build nginx image
echo "building $NGINX_IMAGE_NAME ..."
docker build -t $NGINX_IMAGE_NAME . 

NGINX_CONTAINER_ID=$(docker ps -q -f name=$NGINX_IMAGE_NAME)
if [[ -n "$NGINX_CONTAINER_ID" ]]; then
    # remove mysql image if exists
    echo "removing $NGINX_IMAGE_NAME container with id $NGINX_CONTAINER_ID"
    docker container rm -f $NGINX_CONTAINER_ID
fi
# build nginx image
echo "deploying $NGINX_IMAGE_NAME ..."
docker run -d --network $NETWORK_NAME --name $NGINX_IMAGE_NAME -p 8080:80 $NGINX_IMAGE_NAME