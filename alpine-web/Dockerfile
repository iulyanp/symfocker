FROM alpine:latest

MAINTAINER Iulian Popa <iulyanpopa@gmail.com>

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk update \
    && addgroup -S symfony -g 1000 \
    && adduser -S -s /bin/sh -u 1000 -G symfony symfony

VOLUME /var/www
WORKDIR /var/www