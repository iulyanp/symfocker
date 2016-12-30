FROM iulyanpopa/alpine-web

MAINTAINER Iulian Popa <iulyanpopa@gmail.com>

RUN apk --update add \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
		wget \
		curl \
		git \
		vim \
		libmcrypt-dev \
		php7 \
		php7-zlib \
		php7-fpm \
	    php7-common \
		php7-curl \
		php7-openssl \
		php7-json \
		php7-phar \
		php7-dom \
		php7-gd \
		php7-pdo \
		php7-xml \
		php7-mbstring \
		php7-ctype \
		php7-pdo_mysql \
		php7-memcached \
		php7-soap \
	    php7-apcu \
	    php7-exif \
	    php7-iconv \
	    php7-intl \
	    php7-mcrypt \
	    php7-opcache \
	    php7-posix \
	    openssh-client \
	&& curl -sS https://getcomposer.org/installer | php7 -- --install-dir=/usr/bin --filename=composer \
    && rm -rf /tmp/* \
	&& rm -rf /var/cache/apk/*

ADD php /etc/php7

RUN ln -s /usr/bin/php7 /usr/bin/php

RUN mkdir -p /var/run/symfony \
    && chown -R symfony:symfony /var/www/ \
    && chown -R symfony:symfony /var/run/symfony

RUN mkdir -p /var/log/php-fpm \
    && chown -R symfony:symfony /var/log/php-fpm

ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN ln -s /etc/init.d/php-fpm7 /usr/bin/php-fpm7 \
    && chmod +x /usr/bin/entrypoint.sh

WORKDIR /var/www

CMD entrypoint.sh
