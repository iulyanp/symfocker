FROM alpine:latest

MAINTAINER Iulian Popa <iulyanpopa@gmail.com>

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && echo "@edgecommunity http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && apk update \
    && apk add --upgrade apk-tools@edge \
    && addgroup -S docker -g 1000 \
    && adduser -S -s /bin/sh -u 1000 -G docker docker

VOLUME /var/www
WORKDIR /var/www
