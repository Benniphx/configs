#!/bin/bash

if [ $# -eq 0 ]; then
  echo "$0 usage: <sfname>"
  exit 1
fi

MOUNT_POINT="$HOME/$1"

if [ ! -d "$MOUNT_POINT" ]; then
  mkdir $MOUNT_POINT
fi

sudo mount -t vboxsf -o uid=$(id -u $(whoami)),gid=$(id -g $(whoami)) $1 $MOUNT_POINT
