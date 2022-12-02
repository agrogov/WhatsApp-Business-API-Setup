#!/bin/sh

#[ ! -d "$HOME_APP" ] && echo "$HOME_APP must be volume mounted and WORK env set, e.g." && exit 1
#
#echo "Listing $HOME_APP files:"
#find "$HOME_APP"
#
#mkdir -p "$HOME_APP/whatsapp/waent/data"
#mkdir -p "$HOME_APP/whatsapp/wamedia"
#chmod 777 -R "$HOME_APP" || true

echo "Starting docker-compose with args: $@..."
exec docker-compose up "$@"
