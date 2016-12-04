FROM iulyanpopa/alpine-web

MAINTAINER Iulian Popa <iulyanpopa@gmail.com>

RUN apk --update add nginx

RUN mkdir -p /etc/nginx/sites-available \
    && mkdir -p /etc/nginx/sites-enabled \
    && mkdir -p /var/log/nginx \
    && chown -R symfony /var/log/nginx \
    && chgrp -R symfony /var/log/nginx

COPY nginx.conf /etc/nginx/
COPY vhost.conf /etc/nginx/sites-available/symfony.conf

RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony

CMD ["nginx"]