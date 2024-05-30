#!/bin/bash 

####################################################################################################
##
##  Year:        2024
##  Author:      AR
##  Description: sh script to install and configure docker 
##
##  How To Use: 
##    bash install_docker.sh
##
####################################################################################################

####################################################################################################
##  FUNCTIONS
####################################################################################################

main () {
  echo "$(date) | Installing docker ..."
  
  echo "$(date) | Uninstalling all conflicting packages ..."
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc
  do 
    sudo apt-get remove $pkg
  done

  sudo apt install ca-certificates curl -y 
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  echo "$(date) | Installing latest version of docker ..."
  sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y 
}

####################################################################################################
##  RUNNING MAIN
####################################################################################################

main