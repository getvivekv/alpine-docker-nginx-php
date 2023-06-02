#!/usr/bin/env bash

# This script builds the docker file and pushes to the hub

docker build -t alpine-docker-nginx-php81 .
docker tag alpine-docker-nginx-php81:latest zeroweb/alpine-docker-nginx-php81:latest
docker push zeroweb/alpine-docker-nginx-php81:latest

# Example
# docker run -d --rm --name test -p 80:80 -v `pwd`/src:/var/www/html alpine-docker-nginx-php81