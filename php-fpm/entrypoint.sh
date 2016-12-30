#!/bin/sh

deluser symfony
addgroup -g ${MY_GID:-500} symfony
adduser -u ${MY_UID:-500} -G symfony -g 'Linux User named' -s /bin/sh -D symfony
chown -R symfony:symfony /var/www

su symfony <<USER
    # Install requirements
    composer install

    # Generate database and assets
    php bin/console doctrine:schema:update --force
    php bin/console assets:install --symlink web
    php bin/console security:check

    rm -rf var/cache/*
    rm -rf var/logs/*

    # Give cache and log rights
    chown -R symfony:symfony var
USER

# Start php-fpm
php-fpm7 -F -y /etc/php7/php-fpm.conf
