#!/bin/sh

[ ! -d "$HOME_APP" ] && echo "$HOME_APP must be volume mounted and WORK env set, e.g." && exit 1

echo "Listing $HOME_APP files:"
find "$HOME_APP"

mkdir -p "$HOME_APP/prometheus/data"
mkdir -p "$HOME_APP/grafana"
chmod 777 -R "$HOME_APP"

echo "Starting docker-compose..."
exec docker-compose up
