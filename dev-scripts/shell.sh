#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CDIR=$( pwd )
cd $DIR
CONTAINER_NAME=mapas-run

docker exec -it $CONTAINER_NAME sh /var/www/scripts/shell.sh

cd $CDIR