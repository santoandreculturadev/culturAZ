#!/bin/bash

docker-compose -f docker-compose.prod.yml exec db pg_dump -U mapas -d mapas
