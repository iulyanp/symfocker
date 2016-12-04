#!/bin/sh

# Install requirements
composer install

# Generate database and assets
php bin/console doctrine:schema:update --force
php bin/console assets:install --symlink web
php bin/console security:check

rm -rf var/cache/*
rm -rf var/logs/*

# Give cache and log rights
chmod -R 777 var/

# Start php-fpm
php-fpm -F -y /etc/php/php-fpm.conf
