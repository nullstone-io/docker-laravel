ARG BUILD_PHP_VERSION=8.1
FROM php:${BUILD_PHP_VERSION}-alpine

RUN apk --update add \
  php${BUILD_PHP_VERSION}-fpm php${BUILD_PHP_VERSION}-session php${BUILD_PHP_VERSION}-openssl \
  php${BUILD_PHP_VERSION}-tokenizer php${BUILD_PHP_VERSION}-dom php${BUILD_PHP_VERSION}-fileinfo \
  php${BUILD_PHP_VERSION}-pgsql php-mysqli

WORKDIR /tmp/
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/bin/composer

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
