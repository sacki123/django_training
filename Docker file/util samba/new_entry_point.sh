#!/bin/bash
# @file: new_entry_point.sh
# @brief: 
#   In order to create samba user, 
#   I make a copy from sonohara/samba-ad's entrypoint script
#   and add a code to call create_samba_default_user.sh script.
# @author: AHAN SOU
# @email: ahan.sou@e-software.company
# @date: 2018/08/24

if [ $DOCKER_DEBUG = 1 ]; then
  ls -lrt / | grep docker
  ls -lrt /.docker
fi
source /.docker/config
source /.docker/init.sh
[ -f /.docker/setup ] || {
  source /.docker/setup.sh
  # call the following script to create samba default user
  source /create_samba_default_user.sh
}
source /.docker/service.sh