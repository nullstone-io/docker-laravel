FROM php:8.0-fpm-alpine

RUN apk --update add \
  nodejs npm yarn \
  php8-session php8-openssl \
  php8-tokenizer php8-dom php8-fileinfo \
  php8-pgsql php-mysqli

# Install composer
RUN curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Set up volumes for nginx
VOLUME /etc/nginx/conf.d
VOLUME /etc/nginx/templates
VOLUME /app/public

COPY "php8.0/etc/" /etc/

# Set up root entrypoint
WORKDIR /
COPY ../entrypoint.sh .
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Configure Laravel
WORKDIR /app
EXPOSE 9000
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr

CMD ["php-fpm"]
