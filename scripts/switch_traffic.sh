#!/bin/bash

# Define green and blue container names
GREEN_CONTAINER="app_green"
BLUE_CONTAINER="app_blue"
NGINX_CONTAINER="nginx"

# Get current container in use by nginx
CURRENT=$(docker exec $NGINX_CONTAINER printenv APP_BACKEND)

if [ "$CURRENT" == "app_green:3000" ]; then
  NEW="app_blue:3000"
else
  NEW="app_green:3000"
fi

# Recreate nginx with new backend
docker rm -f $NGINX_CONTAINER
docker run -d \
  --name $NGINX_CONTAINER \
  -p 80:80 \
  --network blue_green_deploy_web \
  -e APP_BACKEND=$NEW \
  -v $(pwd)/nginx/default.conf.template:/etc/nginx/templates/default.conf.template \
  nginx:alpine

echo "Switched traffic to $NEW"
