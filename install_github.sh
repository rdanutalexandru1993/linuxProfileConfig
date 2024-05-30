#!/bin/bash 

####################################################################################################
##
##  Year:        2024
##  Author:      AR
##  Description: sh script to install and configure github 
##
##  How To Use: 
##    bash install_github.sh
##
####################################################################################################

####################################################################################################
##  FUNCTIONS
####################################################################################################

configureUserEmail () {
  echo ""
  read -p "Please insert your git ${1}: " RESPONSE
  echo ""
  if [[ -z ${RESPONSE} ]]
  then 
    echo "$(date) | ${1} has not been provided. Run git config --globa user.${1} \"<${1}>\" to configure at a later stage ..."
  else 
    if [[ "${1}" == "username" ]]
    then
      git config --global user.name ${RESPONSE}
    else
      git config --global user.email ${RESPONSE}
    fi
    echo "$(date) | Git ${1} has been configured successfully ..."
  fi
}

main () {
  echo "$(date) | Installing github ..."
  sudo apt install git-all -y 

  configureUserEmail "username"
  configureUserEmail "email"

  git config --global core.commentchar "#"
  git config --global core.editor "vim"

  echo ""
  echo "Git Configurations: "
  echo "----------------------"
  git config --list 
  echo ""
}

####################################################################################################
##  RUNNING MAIN
####################################################################################################

main