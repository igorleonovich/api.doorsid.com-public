#!/bin/sh

SCRIPT_PATH=$(realpath $0)
DOORS_SERVER_MONOLITH_PATH=$(dirname $SCRIPT_PATH)
docker compose -f $DOORS_SERVER_MONOLITH_PATH/docker-compose-dev.yml restart
