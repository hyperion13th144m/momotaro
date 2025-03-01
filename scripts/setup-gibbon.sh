#!/usr/bin/env bash

# build sparrow and copy to gibbon.

PROJECT_HOME=${1:-$HOME/projects/momotaro}
DST_DIR=$PROJECT_HOME/gibbon/pkgs
[ ! -d $DST_DIR ] && mkdir -p $DST_DIR
rm -f $DST_DIR/sparrow-*

PKG_DIR=/data/packages
PKG_MAP=$DST_DIR:$PKG_DIR
BUILD_CMD="setup.py bdist_wheel -d $PKG_DIR"
IMAGE=hyperion13th144m/sparrow
docker run -u pyuser --rm -v $PKG_MAP $IMAGE $BUILD_CMD
