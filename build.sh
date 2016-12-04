#!/bin/sh

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"

cd $DIR/alpine-web
docker build -t iulyanpopa/alpine-web:$1 -t iulyanpopa/alpine-web:latest .
docker push iulyanpopa/alpine-web:$1
docker push iulyanpopa/alpine-web:latest


cd $DIR/php-fpm
docker build -t iulyanpopa/alpine-php-fpm:$1 -t iulyanpopa/alpine-php-fpm:latest .
docker push iulyanpopa/alpine-php-fpm:$1
docker push iulyanpopa/alpine-php-fpm:latest


cd $DIR/nginx
docker build -t iulyanpopa/alpine-nginx:$1 -t iulyanpopa/alpine-nginx:latest .
docker push iulyanpopa/alpine-nginx:$1
docker push iulyanpopa/alpine-nginx:latest

docker-compose up -d
