FROM php:7.3-apache

RUN apt-get update \
 && apt-get install -y unzip git zlib1g-dev libzip-dev libicu-dev libpng-dev libjpeg-dev libfreetype6-dev libcurl4-openssl-dev pkg-config libssl-dev libldap2-dev \
 && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install zip pdo_mysql intl gd ldap \
 && pecl install xdebug \
 && docker-php-ext-enable xdebug \
 && pecl install mongodb \
 && docker-php-ext-enable mongodb \
 && a2enmod rewrite \
 && sed -i 's!/var/www/html!/var/www/public!g' /etc/apache2/sites-available/000-default.conf \
 && mv /var/www/html /var/www/public \
 && curl -sS https://getcomposer.org/installer \
  | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www
