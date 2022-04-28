FROM php:8-alpine

RUN apk --update add composer \
  php8-fpm php8-session php8-openssl php8-tokenizer \
  php8-pgsql php-mysqli

VOLUME /etc/nginx/conf.d
VOLUME /etc/nginx/templates
VOLUME /app/public

COPY etc/ /etc/

# Set up root entrypoint
WORKDIR /
COPY docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

# Set up entrypoints dir
WORKDIR /docker-entrypoint.d/
COPY ./docker-entrypoint.d/*.sh .
RUN chmod +x /docker-entrypoint.d/*.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# Configure Laravel
ONBUILD WORKDIR /app
ONBUILD COPY --chown=nobody:nobody . .
ONBUILD RUN composer install --no-dev
ONBUILD ENV LOG_CHANNEL=stderr

EXPOSE 9000
CMD php-fpm8
