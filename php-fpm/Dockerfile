FROM symfony-base

MAINTAINER Iulian Popa <iulyanpopa@gmail.com>

RUN apk --update add wget curl git php php-curl php-openssl php-json php-phar php-dom php-gd php-pdo php-xml php-ctype php-fpm php-pdo_mysql php-memcache php-soap && \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

ADD php /etc/php

RUN mkdir -p /var/run/symfony && \
    chown -R symfony /var/www/ && \
    chown -R symfony /var/run/symfony && \
    chmod -R 0777 /var/run/symfony

RUN mkdir -p /var/log/php-fpm && \
    chown -R symfony /var/log/php-fpm && \
    chgrp -R symfony /var/log/php-fpm && \
    chmod -R 0777 /var/log/php-fpm

ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

VOLUME /var/run/symfony
VOLUME /var/www

WORKDIR /var/www

CMD entrypoint.sh
