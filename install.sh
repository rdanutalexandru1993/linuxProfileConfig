#!/bin/bash 

####################################################################################################
##
##  Year:        2014
##  Author:      AR
##  Description: sh script to configure your copy of linux 
##
##  How To Use: 
##    install.sh 
##    install.sh --modules python docker 
##
####################################################################################################

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
    echo "    $0 --module python docker"
    echo ""
    echo "##########################################################################################"
}

main () {
  local MODULE=${1}

  echo "$MODULE"

  for m in "${MODULE[@]}"; do 
    echo "$m"
  done
}

####################################################################################################
##  DEFAULT VALUES 
####################################################################################################

while true; do
    case "$1" in
        -m|--modules)
            echo "$2"
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

main ${MODULE}