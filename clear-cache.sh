#!/bin/bash

DIR=$( dirname "${BASH_SOURCE[0]}")

echo $DIR

docker-compose -f $DIR/docker-compose.prod.yml restart redis
