ARG PHP_VERSION=8.1
FROM php:${PHP_VERSION}-alpine

RUN apk --update add composer \
  php8-fpm php8-session php8-openssl php8-tokenizer php8-dom php8-fileinfo \
  php8-pgsql php-mysqli

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
