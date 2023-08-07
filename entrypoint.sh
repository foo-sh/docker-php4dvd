#!/bin/sh

set -eu

: "${PHP4DVD_DB_HOST:=${PHP4DVD_DB_HOST:-localhost}}"
: "${PHP4DVD_DB_PORT:=${PHP4DVD_DB_PORT:-3306}}"
: "${PHP4DVD_DB_NAME:=${PHP4DVD_DB_NAME:-php4dvd}}"
: "${PHP4DVD_DB_USER:=${PHP4DVD_DB_USER:-php4dvd}}"
: "${PHP4DVD_DB_PASS:=${PHP4DVD_DB_PASS:-}}"
: "${PHP4DVD_USER_GUESTVIEW:=${PHP4DVD_USER_GUESTVIEW:-false}}"

cat <<EOF > /var/www/html/config/config.php
<?php
defined('DIRECTACCESS') OR exit('No direct script access allowed');
\$settings["db"]["host"] = "${PHP4DVD_DB_HOST}";
\$settings["db"]["port"] = "${PHP4DVD_DB_PORT}";
\$settings["db"]["name"] = "${PHP4DVD_DB_NAME}";
\$settings["db"]["user"] = "${PHP4DVD_DB_USER}";
\$settings["db"]["pass"] = "${PHP4DVD_DB_PASS}";
\$settings["user"]["guestview"] = ${PHP4DVD_USER_GUESTVIEW};
EOF
chown root:www-data /var/www/html/config/config.php
chmod 640 /var/www/html/config/config.php

exec /usr/local/bin/docker-php-entrypoint "$@"
