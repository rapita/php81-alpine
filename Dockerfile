# See: <https://roadrunner.dev/docs/intro-install>
FROM spiralscout/roadrunner:2.10.7 as roadrunner
# See: <https://github.com/mlocati/docker-php-extension-installer>
FROM mlocati/php-extension-installer:latest as php-extension-installer
FROM php:8.1.8-alpine AS base

COPY --from=php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=roadrunner /usr/bin/rr /usr/local/bin/rr

# install php extensions and components
RUN install-php-extensions \
        @fix_letsencrypt \
        amqp \
        bcmath \
        grpc \
        igbinary \
        imagick \
        mysqli \
        opcache \
        pcntl \
        pgsql \
        pdo_mysql \
        pdo_pgsql \
        rdkafka \
        redis \
        sockets \
        yaml \
        zip \
        xdebug-^3.1 \
        @composer-^2

COPY php.ini /usr/local/etc/php/php.ini

# disable xdebug by default
RUN echo '' > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
