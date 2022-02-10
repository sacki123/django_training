#!/bin/bash

SERVER_LIST="172.16.20.155 172.16.20.165 172.16.20.185"
DELETE_TIME="600h"
echo "Welcome to the [ZEN PROD] deployment tool"
echo "Do you want to update deployed containers? "
echo "1). yes"
echo "2). no"
read -p "Please, select an option:" answer
if [ $answer = "1" ]; then
  for server in $SERVER_LIST; do
    echo "updating server $server..."
    echo "copying .env file..."
    scp /export/.env root@$server:/export/.env
    echo "upgrading containers..."
    dc=$(ssh root@$server "ls -1 /export/docker-compose* | head -1")
    ssh root@$server " docker-compose -f $dc up -d"
    echo "deleting old container images (>${DELETE_TIME} old and not used)"
    ssh root@$server "docker image prune -a --filter \"until=${DELETE_TIME}\" --force"
  done;
  echo "deleting local old images..."
  docker image prune -a --filter "until=${DELETE_TIME}" --force
else
  echo "Nothing to do."
  exit
fi

