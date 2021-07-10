#!/bin/sh

# Usage copyFromPi.sh <username>@<ip-address or name>

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <username>@<ip-address or name>" >&2
  exit 1
fi

echo copying all config files from $1
scp $1:/usr/share/X11/xorg.conf.d/99-fbturbo.conf usr/share/X11/xorg.conf.d
scp $1:/boot/config.txt boot
scp $1:/etc/init.d/raspi3-dual etc/init.d