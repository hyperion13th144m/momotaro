#!/bin/bash

function usage(){
    echo Usage: $0 start \| stop \| restart
}

SERVICES="poodle terrier pheasant nginx groonga"
UP_OPT="up -d"
DOWN_OPT="down"

case "$1" in
    "start" )
        docker compose $UP_OPT $SERVICES
        ;;
    "stop" )
        docker compose $DOWN_OPT
        ;;
    "restart" )
        docker compose $DOWN_OPT
        docker compose $UP_OPT $SERVICES
        ;;
    "*" )
        usage
        ;;
esac
exit 0

