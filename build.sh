#!/bin/sh

DEPLOYMENT_ENVIRONMENT="development"
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
  else
    case "$1" in
      dev) DEPLOYMENT_ENVIRONMENT="development"
          ;;
      stage) DEPLOYMENT_ENVIRONMENT="staging"
          ;;
      prod) DEPLOYMENT_ENVIRONMENT="production"
          ;;
    esac
fi
SCRIPT_PATH=$(realpath $0)
DOORS_SERVER_MONOLITH_PATH=$(dirname $SCRIPT_PATH)
docker-compose -f ${DOORS_SERVER_MONOLITH_PATH}/docker-compose.${DEPLOYMENT_ENVIRONMENT}.yml --env-file ${DOORS_SERVER_MONOLITH_PATH}/.env.${DEPLOYMENT_ENVIRONMENT} build
