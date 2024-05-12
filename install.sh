#!/bin/bash 

####################################################################################################
##
##  Year:        2024
##  Author:      AR
##  Description: sh script to configure your copy of linux 
##
##  How To Use: 
##    install.sh 
##    install.sh --modules python docker 
##
####################################################################################################

if [ "-bash" = $0 ]; then
  dirpath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
  dirpath="$(cd "$(dirname "$0")" && pwd)"
fi

export INSTALL_HOME=${dirpath}

####################################################################################################
##  FUNCTIONS
####################################################################################################

help () {
    echo "##########################################################################################"
    echo ""
    echo "  Usage: $0 --module [options]"
    echo ""
    echo "  Options:"
    echo "    -h, --help      Display this help message"
    echo "    -m, --module    One or a list of modules" 
    echo "                    Modules names need an .sh script associated" 
    echo "                      with them in the same location"
    echo ""
    echo "  Example:"
    echo "    $0 --modules \"python docker\""
    echo ""
    echo "  Available scripts: "
    echo ""
    echo "    python - install python"
    echo "    docker - install docker"
    echo "    github - install and configure github"
    echo "    env    - set environment variables"
    echo "    alias  - set aliases"
    echo "    vim    - install vim"
    echo ""
    echo "##########################################################################################"
}

checkModules () {
  local MODULE_ARRAY
  MODULE_ARRAY="$1"
  # if modules passed is empty, search for pattern and form the modules array 
  if [[ ! -z "$MODULE_ARRAY" ]]
  then 
    echo "${MODULE_ARRAY[@]}"
  else
    local MODULE_ARRAY=( $(find ${PWD} -name "*install_*sh" -type f) )
    
    for MODULE in "${MODULE_ARRAY[@]}"
    do
      local FNAME=$(basename "$MODULE")
      # user passes modules like env python , but when searching for modules we get full paths 
      # which is why we modify the name of the module to work with the rest of the code
      # drop install_
      FNAME="${FNAME#install_}"
      # drop .sh
      FNAME="${FNAME%.sh}"
      echo "$FNAME"
    done
  fi 
}

runInstallScript () {
  local SCRIPTNAME="install_${1}.sh"

  echo "$(date) | Running $SCRIPTNAME ... "

  local SCRIPTPATH=$(find ${PWD} -type f -name "$SCRIPTNAME")
  
  if [[ -z "$SCRIPTPATH" ]]
  then 
    echo "$(date) | File $SCRIPTNAME does not exit ... "
  else 
    bash "$SCRIPTPATH"
  fi 
}

main () {
  # if the passed array of modules is empty, search for install modules in local working directory 
  local MODULES=( $(checkModules "$1") ) 

  for M in "${MODULES[@]}"
  do 
    runInstallScript "$M"
  done
}

####################################################################################################
##  DEFAULT VALUES 
####################################################################################################

while [[ $# -gt 0 ]]; do
    case "$1" in
        -m|--modules)
            MODULES="$2"
            shift 2
            ;;
        -h|--help)
            help
            exit 1
            ;;
        *)
            echo "$(date) | Internal error!"
            exit 1 
            ;;
    esac
done

####################################################################################################
##  RUNNING MAIN
####################################################################################################

main "${MODULES}"
