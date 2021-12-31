#!/bin/bash

# /!\ WARNING: RESET EVERYTHING! 
# Remove all containers/networks/volumes
# stop the main docker-compose
docker-compose down

# stop docker-compose.kafka
docker-compose -f docker-compose.kafka.yml down

docker system prune -f
docker volume prune -f
docker network prune -f
