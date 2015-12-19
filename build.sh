#!/bin/sh
docker build -t symfony-base web-base
docker build -t symfony-php-fpm php-fpm
docker build -t symfony-nginx nginx
docker-compose up -d
