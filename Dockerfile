ARG PHP_VERSION=7.1

FROM php:${PHP_VERSION}-cli-alpine

ARG XDEBUG_VERSION=2.5.5

RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS zlib-dev \
    && apk add --no-cache --virtual .runtime-deps git \
    && docker-php-ext-install zip \
    && pecl install xdebug-$XDEBUG_VERSION ds \
    && docker-php-ext-enable xdebug ds \
    && echo "xdebug.max_nesting_level=15000" >> "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini" \
    && echo "xdebug.remote_enable=true" >> "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini" \
    && echo "xdebug.remote_host=localhost" >> "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini" \
    && echo "xdebug.idekey=PHPSTORM" >> "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini" \
    && echo "xdebug.remote_handler=dbgp" >> "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini" \
    && echo "xdebug.remote_autostart=1" >> "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini" \
    && echo "xdebug.remote_connect_back=0" >> "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini" \
    && apk del .build-deps
