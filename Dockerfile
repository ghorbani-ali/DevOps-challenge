FROM php:8.2-fpm-alpine

RUN apk add git

COPY --from=composer:lts /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html
COPY . /var/www/html

RUN set -eux && \
    composer install && \
    find /var/www/html/public -type d -exec chmod 755 {} ";" && \
    find /var/www/html/public -type f -exec chmod 644 {} ";" && \
    chown -R root:www-data /var/www/html/storage/ && \
    chmod -R 775 storage && \
    php artisan optimize:clear && \
    php artisan optimize