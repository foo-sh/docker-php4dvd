FROM php:8.2.8-apache

ARG VERSION="3.11.4"

RUN set -eux ; \
    apt-get update ; \
    apt-get -y upgrade ; \
    apt-get -y install --no-install-recommends \
        libpng-dev \
        libzip-dev \
    ; \
    rm -rf /var/lib/apt/lists/* ; \
    docker-php-ext-install \
        gd \
        pdo_mysql

RUN set -eux ; \
    curl -sfL "https://github.com/jreklund/php4dvd/archive/refs/tags/v${VERSION}.tar.gz" | tar zxvf - --strip-components=1 ; \
    chmod 770 cache compiled movies movies/covers ; \
    chown www-data:www-data cache compiled movies movies/covers ; \
    rm -rf install

COPY entrypoint.sh /usr/local/sbin
ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]
CMD ["apache2-foreground"]
