FROM iulyanpopa/alpine-web

MAINTAINER Iulian Popa <iulyanpopa@gmail.com>

RUN apk --update add \
		wget \
		curl \
		git \
		vim \
		php5 \
		php5-curl \
		php5-openssl \
		php5-json \
		php5-phar \
		php5-dom \
		php5-gd \
		php5-pdo \
		php5-xml \
		php5-ctype \
		php5-fpm \
		php5-pdo_mysql \
		php5-memcache \
		php5-soap \
	    php5-apcu \
	    php5-common \
	    php5-exif \
	    php5-iconv \
	    php5-intl \
	    php5-mcrypt \
	    php5-opcache \
	    php5-posix \
	    openssh-client \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
    && rm -rf /tmp/* \
	&& rm -rf /var/cache/apk/*

ADD php /etc/php

RUN mkdir -p /var/run/symfony \
    && chown -R symfony:symfony /var/www/ \
    && chown -R symfony:symfony /var/run/symfony

RUN mkdir -p /var/log/php-fpm \
    && chown -R symfony:symfony /var/log/php-fpm

ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

WORKDIR /var/www

CMD entrypoint.sh
