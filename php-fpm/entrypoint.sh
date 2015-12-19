#!/bin/sh
# Install requirements
composer update
# Generate database and assets
php app/console doctrine:schema:update --force
php app/console assetic:dump --env=prod
php app/console assets:install --symlink web
chmod -R 777 app/cache/
chmod -R 777 app/logs/

php-fpm -F -y /etc/php/php-fpm.conf