FROM php:7.1-apache

RUN apt-get update \
  && apt-get install -y \
  git-core \
  libpq-dev \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  zlib1g-dev \
  zip \
  unzip

RUN docker-php-ext-install zip mysqli pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

COPY default-vhost.conf /etc/apache2/sites-available/default.conf
RUN a2dissite 000-default.conf && a2ensite default.conf && a2enmod rewrite

RUN usermod -u 1000 www-data && groupmod -g 1000 www-data