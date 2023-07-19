ARG BUILD_PHP_VERSION=8.1
FROM php:${BUILD_PHP_VERSION}-alpine

RUN apk --update add \
  php${BUILD_PHP_VERSION}-fpm php${BUILD_PHP_VERSION}-session php${BUILD_PHP_VERSION}-openssl \
  php${BUILD_PHP_VERSION}-tokenizer php${BUILD_PHP_VERSION}-dom php${BUILD_PHP_VERSION}-fileinfo \
  php${BUILD_PHP_VERSION}-pgsql php-mysqli

# Install composer
WORKDIR /tmp/
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/bin/composer

# Set up volumes for nginx
VOLUME /etc/nginx/conf.d
VOLUME /etc/nginx/templates
VOLUME /app/public

COPY etc/ /etc/

# Set up root entrypoint
WORKDIR /
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Configure Laravel
WORKDIR /app
EXPOSE 9000
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr

CMD ["php-fpm8"]
