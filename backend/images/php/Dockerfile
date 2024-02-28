FROM php:8.1.23-fpm-alpine3.17

RUN apk add --no-cache \
    \
    libzip-dev \
    \
    icu-dev \
    libxml2-dev \
    \
    mysql-client \
    tzdata \
    git \
    bash

RUN docker-php-ext-install  intl bcmath zip pcntl pdo_mysql mysqli  \
  && docker-php-ext-enable opcache

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

RUN apk update && apk upgrade

RUN apk add --no-cache sqlite

# Xdebug: https://stackoverflow.com/questions/46825502/how-do-i-install-xdebug-on-dockers-official-php-fpm-alpine-image
# PHPIZE_DEPS: autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c
#RUN set -eux; \
#    apk add --no-cache --virtual .build-dependencies $PHPIZE_DEPS; \
#    apk add --no-cache --virtual .deps linux-headers; \
#    pecl install xdebug-3.2.1; \
#    docker-php-ext-enable xdebug; \
#    docker-php-source delete; \
#    apk del .deps; \
#    apk del .build-dependencies
#RUN set -eux; \
#    { \
#        echo "[xdebug]"; \
#        echo "zend_extension=xdebug"; \
#        echo "xdebug.mode=debug"; \
#        echo "xdebug.start_with_request=yes"; \
#        echo "xdebug.client_host=host.docker.internal"; \
#        echo "xdebug.client_port=9003"; \
#        echo "xdebug.ide_key=PHPSTORM"; \
#    } > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini;

RUN set -ex \
  && apk --no-cache add \
    postgresql-dev

RUN docker-php-ext-install pdo pdo_pgsql

WORKDIR /var/www/html
# Add app
COPY . ./


STOPSIGNAL SIGQUIT

EXPOSE 9000

CMD ["php-fpm", "-R", "-F"]