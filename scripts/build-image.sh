#!/bin/sh

while getopts d: OPT
do
  case $OPT in
  d) PROJECT_HOME=$OPTARG
    ;;
  *) exit 1
    ;;
  esac
done

### set project home dir
PROJECT_HOME=${PROJECT_HOME:-`pwd`}
[ ! -d $PROJECT_HOME ] && echo 'no project dir specified' && exit 1

### get arguments except options to TARGET
shift $((OPTIND - 1))
if [ $# -eq 0 ]; then
  TARGET="poodle gibbon terrier pheasant groonga nginx"
else
  TARGET="$@"
fi

### build docker images and call setup scripts if exists
for t in "$TARGET"; do
  if [ -f ./scripts/setup-$t.sh ]; then
    ./scripts/setup-$t.sh
  fi

  docker compose -f docker-compose.build.yaml build $t
done
