FROM php:8.0-fpm-alpine

RUN apk --update add \
  nodejs npm yarn \
  php8-session php8-openssl \
  php8-tokenizer php8-dom php8-fileinfo \
  php8-pgsql php-mysqli

# Install composer
RUN curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Set up root entrypoint
WORKDIR /
COPY ../local.entrypoint.sh .
RUN chmod +x local.entrypoint.sh
ENTRYPOINT ["/local.entrypoint.sh"]

# Configure Laravel
WORKDIR /app
EXPOSE 9000
ENV SERVER_HOST 0.0.0.0
ENV SERVER_PORT 9000
ENV APP_DEBUG true
ENV APP_ENV local
ENV LOG_CHANNEL stderr

CMD ["php", "artisan", "serve"]
