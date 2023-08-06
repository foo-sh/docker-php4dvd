FROM php:8.2.8-apache

ARG VERSION="3.11.4"

RUN set -eux ; \
    apt-get update ; \
    apt-get -y upgrade ; \
    rm -rf /var/lib/apt/lists/*

RUN set -eux ; \
    curl -sfL "https://github.com/jreklund/php4dvd/archive/refs/tags/v${VERSION}.tar.gz" | tar zxvf - --strip-components=1 ; \
    chmod 770 cache compiled config movies movies/covers ; \
    chown www-data:www-data cache compiled config movies movies/covers
