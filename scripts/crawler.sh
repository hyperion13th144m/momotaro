#!/bin/bash


while getopts ft:s: OPT
do
  case $OPT in
  d) PROJECT_HOME=$OPTARG
    ;;
  f) FORCE_UPDATE=1
    ;;
  t) FILTERS=$OPTARG
    ;;
  s) SRC_DIR=$OPTARG
    ;;
  *) exit 1
    ;;
  esac
done

### set project home dir
PROJECT_HOME=${PROJECT_HOME:-`pwd`}
[ ! -d $PROJECT_HOME ] && echo 'no project dir specified' && exit 1

SRC_DIR=${SRC_DIR:-/data/src}
[ -v FORCE_UPDATE ] && FORCE_UPDATE='--force'
[ -v FILTERS ] && FILTERS="--filters $FILTERS"

cd $PROJECT_HOME
if [ -f docker-compose.yaml ]; then
  echo docker compose -f docker-compose.yaml run --rm gibbon $FILTERS $FORCE_UPDATE $SRC_DIR http://groonga:10041/d http://poodle:8000
  docker compose -f docker-compose.yaml run --rm gibbon $FILTERS $FORCE_UPDATE $SRC_DIR http://groonga:10041/d http://poodle:8000
  exit $?
else
  exit 1
fi
