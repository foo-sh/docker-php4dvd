#!/bin/sh

set -eu

cp /var/www/html/config/config.default.php /var/www/html/config/config.php
chmod 640 /var/www/html/config/config.php
chown root:www-data /var/www/html/config/config.php

if [ "${PHP4DVD_DB_HOST:-}" != "" ]; then
    sed -i -e "s%^\(\$settings\[\"db\"\]\[\"host\"\] = \).*%\1\"${PHP4DVD_DB_HOST}\";%" /var/www/html/config/config.php
    unset PHP4DVD_DB_HOST
fi

if [ "${PHP4DVD_DB_PORT:-}" != "" ]; then
    sed -i -e "s%^\(\$settings\[\"db\"\]\[\"port\"\] = \).*%\1\"${PHP4DVD_DB_PORT}\";%" /var/www/html/config/config.php
    unset PHP4DVD_DB_PORT
fi

if [ "${PHP4DVD_DB_NAME:-}" != "" ]; then
    sed -i -e "s%^\(\$settings\[\"db\"\]\[\"name\"\] = \).*%\1\"${PHP4DVD_DB_NAME}\";%" /var/www/html/config/config.php
    unset PHP4DVD_DB_NAME
fi

if [ "${PHP4DVD_DB_USER:-}" != "" ]; then
    sed -i -e "s%^\(\$settings\[\"db\"\]\[\"port\"\] = \).*%\1\"${PHP4DVD_DB_USER}\";%" /var/www/html/config/config.php
    unset PHP4DVD_DB_USER
fi

if [ "${PHP4DVD_DB_PASS:-}" != "" ]; then
    sed -i -e "s%^\(\$settings\[\"db\"\]\[\"port\"\] = \).*%\1\"${PHP4DVD_DB_PASS}\";%" /var/www/html/config/config.php
    unset PHP4DVD_DB_PASS
fi

if [ "${PHP4DVD_BASEURL:-}" != "" ]; then
    sed -i -e "s%^\(\$settings\[\"url\"\]\[\"base\"\] = \).*%\1\"${PHP4DVD_BASEURL}\";%" /var/www/html/config/config.php
    unset PHP4DVD_BASEURL
fi

exec /usr/local/bin/docker-php-entrypoint "$@"
