#!/bin/bash
docker pull mapasculturais/mapasculturais:v7.0.0
git pull

git submodule update

docker-compose -f docker-compose.prod.yml build --no-cache

docker-compose -f docker-compose.prod.yml stop mapasculturais
docker-compose -f docker-compose.prod.yml start mapasculturais