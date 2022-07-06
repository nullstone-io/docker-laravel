ARG BUILD_PHP_VERSION=8.1
FROM php:${BUILD_PHP_VERSION}-alpine

RUN apk --update add composer \
  php${BUILD_PHP_VERSION}-fpm php${BUILD_PHP_VERSION}-session php${BUILD_PHP_VERSION}-openssl \
  php${BUILD_PHP_VERSION}-tokenizer php${BUILD_PHP_VERSION}-dom php${BUILD_PHP_VERSION}-fileinfo \
  php${BUILD_PHP_VERSION}-pgsql php-mysqli

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
