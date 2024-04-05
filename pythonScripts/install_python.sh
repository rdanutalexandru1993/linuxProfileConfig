#!/bin/bash 

####################################################################################################
##
##  Year:        2024
##  Author:      AR
##  Description: sh script to install and configure python 
##
##  How To Use: 
##    bash install_python.sh
##
####################################################################################################

####################################################################################################
##  FUNCTIONS
####################################################################################################

main () {
  echo "$(date) | Installing python3 ..."
  sudo apt install python3 
  sudo apt install python3-pip 

  if [[ $(dpkg -l | grep python3 | wc -l) -gt 0 && $(dpkg -l | grep python3-pip | wc -l) -gt 0 ]]
  then
    local REQUIREMENTS_LOCATION=$(find ${PWD} -name requirements.txt)
    if [[ -z ${REQUIREMENTS_LOCATION} ]]
    then
      echo "$(date) | There is no requirements file ... "
    else 
      echo "$(date) | Installing packages specified in the requirements.txt ... "
      sudo pip ${REQUIREMENTS_LOCATION}
    fi
  else  
    echo "$(date) | Something went wrong durinh python3 installation ... "
  fi
}

####################################################################################################
##  RUNNING MAIN
####################################################################################################

main