#!/bin/sh

DEFAULT_TARGET="poodle gibbon terrier pheasant groonga nginx"
if [ $# -ge 1 ]; then
  TARGET=$@
else
  TARGET=$DEFAULT_TARGET
fi


push_images() {
    for p in $TARGET
    do
      tag=$(git rev-parse --short HEAD)
      docker tag hyperion13th144m/momotaro-$p:latest hyperion13th144m/momotaro-$p:$tag 
      docker push hyperion13th144m/momotaro-$p:latest
      docker push hyperion13th144m/momotaro-$p:$tag
    done
}

push_images

