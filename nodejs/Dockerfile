FROM iulyanpopa/alpine-web

MAINTAINER Iulian Popa <iulyanpopa@gmail.com>

RUN apk --update add nodejs \
    && rm -rf /tmp \
    && rm -rf /var/cache/apk/*

VOLUME /var/www
WORKDIR /var/www

EXPOSE 3000

CMD ["node"]