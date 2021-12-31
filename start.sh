#!/bin/bash

# Build the base images from which are based the Dockerfiles
# then Startup all the containers at once
docker-compose -f docker-compose.kafka.yml up

