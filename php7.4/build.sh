#!/usr/bin/env bash

# This script builds the docker file and pushes to the hub

docker build -t alpine-docker-nginx-php7 .
docker tag alpine-docker-nginx-php7:latest getvivekv/alpine-docker-nginx-php7:latest
docker push getvivekv/alpine-docker-nginx-php7:latest

# Example
# docker run -d --rm --name test -p 80:80 -v `pwd`/src:/var/www/html alpine-docker-nginx-php7