#!/bin/bash 

####################################################################################################
##
##  Year:        2024
##  Author:      AR
##  Description: sh script to set environment variables
##
##  How To Use: 
##    bash install_env.sh
##
####################################################################################################

####################################################################################################
##  FUNCTIONS
####################################################################################################

main () {
  local PTH=$(find ${INSTALL_HOME} -name aliases.txt -type f)
  local NEWENVSRC=.bash_${USER}_alias

  echo "$(date) | Setting aliases ... "
  cp ${PTH} ${HOME}/${NEWENVSRC}

  # checking to see if there is a line in .bashrc to source the env variables from the newly created 
  #   file

  if [[ 1 -eq $(cat ${HOME}/.bashrc | grep "${NEWENVSRC}" | wc -l) ]]
  then 
    echo "$(date) | There is already a line sourcing ${NEWENVSRC} in .bashrc ... "
  else 
    echo "$(date) | Adding line to source ${NEWENVSRC} to .bashrc ... "
    echo "" >> ${HOME}/.bashrc 
    echo "# Sourcing user environment variables" >> ${HOME}/.bashrc 
    echo "source ./${NEWENVSRC}" >> ${HOME}/.bashrc 
    echo "" >> ${HOME}/.bashrc 
  fi
}

####################################################################################################
##  RUNNING MAIN
####################################################################################################

main