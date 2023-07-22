FROM php:8.1-fpm-alpine

RUN apk --update add \
  nodejs npm yarn \
  php81-session php81-openssl \
  php81-tokenizer php81-dom php81-fileinfo \
  php81-pgsql php-mysqli

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
