#!/bin/bash
REGISTRY_PATH="172.16.20.187:5000"
REGISTRY_NAME="zen"
ENV_FILE_LOCATION="/export/.env"
# service names
WEB_DJANGO="web-django"
WEB_REVERSE_PROXY="web-reverse-proxy"
WEB_ADMINER="web-adminer"
DB_MARIADB="db-mariadb"
DB_REDIS="db-redis"
STORAGE_MARIADB_BATCH="storage-mariadb-batch"
STORAGE_ZENKO="storage-zenko"
BATCH_PYTHON_LUIGI="batch-python-luigi"
BATCH_SAMBA_AD="batch-samba-ad"

VERSION_TO_UPDATE=""


echo "Welcome to the [ZEN PROD] deployment tool"
echo "1). ${WEB_DJANGO}"
echo "2). ${WEB_REVERSE_PROXY}"
echo "3). ${WEB_ADMINER}"
echo "4). ${DB_MARIADB}"
echo "5). ${DB_REDIS}"
echo "6). ${STORAGE_MARIADB_BATCH}"
echo "7). ${STORAGE_ZENKO}"
echo "8). ${BATCH_PYTHON_LUIGI}"
echo "9). ${BATCH_SAMBA_AD}"
read -p "Please choose a service to deploy : " service_num
if [ $service_num = "1" ]; then
  service_name="${WEB_DJANGO}"
  VERSION_TO_UPDATE="WEB_DJANGO_VERSION"
elif [ $service_num = "2" ]; then
  service_name="${WEB_REVERSE_PROXY}"
  VERSION_TO_UPDATE="WEB_REVERSE_PROXY_VERSION"
elif [ $service_num = "3" ]; then
  service_name="${WEB_ADMINER}"
  VERSION_TO_UPDATE="WEB_ADMINER_VERSION"
elif [ $service_num = "4" ]; then
  service_name="${DB_MARIADB}"
  VERSION_TO_UPDATE="DB_MARIADB_VERSION"
elif [ $service_num = "5" ]; then
  service_name="${DB_REDIS}"
  VERSION_TO_UPDATE="DB_REDIS_VERSION"
elif [ $service_num = "6" ]; then
  service_name="${STORAGE_MARIADB_BATCH}"
  VERSION_TO_UPDATE="STORAGE_MARIADB_BATCH_VERSION"
elif [ $service_num = "7" ]; then
  service_name="${STORAGE_ZENKO}"
  VERSION_TO_UPDATE="STORAGE_ZENKO_VERSION"
elif [ $service_num = "8" ]; then
  service_name="${BATCH_PYTHON_LUIGI}"
  VERSION_TO_UPDATE="BATCH_PYTHON_LUIGI_VERSION"
elif [ $service_num = "9" ]; then
  service_name="${BATCH_SAMBA_AD}"
  VERSION_TO_UPDATE="BATCH_SAMBA_AD_VERSION"
else
  echo "Unexpected value has been inputted, do nothing, bye."
  exit
fi
if [ "$(docker images | grep ${service_name})" != "" ]; then
  previous_ver=$(docker images | grep ${REGISTRY_NAME}/${service_name} | tr -s ' ' | cut -d ' ' -f2)
  echo "The following images will be deleted. "
  echo "[${service_name}]"
  echo "[${REGISTRY_PATH}/${REGISTRY_NAME}/${service_name}:${previous_ver}]"
  echo "1). yes"
  echo "2). no"
  read -p "Please select the options : " answer
  if [ $answer = "1" ]; then
    docker rmi "${REGISTRY_PATH}/${REGISTRY_NAME}/${service_name}:${previous_ver}"
    docker rmi "${service_name}"
    if [ "$(docker images | grep ${service_name})" = "" ]; then
      echo "Succeed to delete the images."
    else
      echo "Some error happend during the delete of images, please check."
      exit
    fi
  #else
  #  echo "Do nothing, bye."
  #  exit
  fi
fi
echo "Starting to build the new [${service_name}] image"
read -p "Please enter the new [${service_name}] image's version : " version
if [ "${version}" != "" ]; then
  echo "The following images will be built:"
  echo "[${service_name}]"
  echo "[${REGISTRY_PATH}/${REGISTRY_NAME}/${service_name}:${version}]"
  echo "1). yes"
  echo "2). no"
  read -p "Please select the options : " answer
  if [ "${answer}" = "1" ]; then
    docker build ./${service_name} -t ${service_name}
    docker tag ${service_name} ${REGISTRY_PATH}/${REGISTRY_NAME}/${service_name}:${version}
    echo "Succeed to build the [${service_name}] and [${REGISTRY_PATH}/${REGISTRY_NAME}/${service_name}:${version}]"
    echo "Do you want to push the following image to the private regisrty?"
    echo "[${REGISTRY_PATH}/${REGISTRY_NAME}/${service_name}:${version}]"
    echo "1). yes"
    echo "2). no"
    read -p "Please select the options : " answer
    if [ "${answer}" = "1" ]; then
      docker push ${REGISTRY_PATH}/${REGISTRY_NAME}/${service_name}:${version}
      #updating image version
      sed -i "s/${VERSION_TO_UPDATE}=.*/${VERSION_TO_UPDATE}=${version}/g" ${ENV_FILE_LOCATION}
    fi
    echo "Finish the deploy process."
  else
    echo "Do nothing, bye."
    exit
  fi
else
  echo "Image version can't be empty. Do nothing, bye."
  exit
fi

