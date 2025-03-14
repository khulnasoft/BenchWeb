FROM php:8.3-cli

RUN apt-get update -yqq >> /dev/null
RUN apt-get install -y libevent-dev \
    libssl-dev \
    pkg-config \
    build-essential \
    unzip >> /dev/null

RUN docker-php-ext-install pdo_mysql \
    opcache \
    posix \
    pcntl \
    sockets >> /dev/null

RUN pecl install event >> /dev/null

RUN docker-php-ext-enable pdo_mysql opcache posix pcntl sockets
RUN docker-php-ext-enable --ini-name zz-event.ini event
RUN echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
RUN echo "opcache.jit=1205" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
RUN echo "opcache.jit_buffer_size=128M" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

COPY --from=composer --link /usr/bin/composer /usr/local/bin/composer

# Initialize
WORKDIR /laravel
COPY --link . .

RUN mkdir -p bootstrap/cache \
            storage/logs \
            storage/framework/sessions \
            storage/framework/views \
            storage/framework/cache

RUN echo "PRP_HTTP_LISTEN=http://0.0.0.0:8080" >> .env
RUN echo "PRP_HTTP_WORKERS=64" >> .env
RUN echo "PRP_HTTP_RELOAD=0" >> .env
RUN echo "PRP_HTTP_SANDBOX=1" >> .env

# Configure
RUN composer install --quiet
RUN composer require cloudtay/ripple-driver --quiet
RUN php artisan vendor:publish --tag=ripple-config
RUN php artisan optimize

# Start
EXPOSE 8080
ENTRYPOINT ["php","artisan","ripple:server","start"]
