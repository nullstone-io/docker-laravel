FROM php:8.1-fpm-alpine

RUN apk --update add \
  nodejs npm yarn \
  php81-session php81-openssl \
  php81-tokenizer php81-dom php81-fileinfo \
  php81-pgsql php-mysqli

# Install composer
RUN curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Set up volumes for nginx
VOLUME /etc/nginx/conf.d
VOLUME /etc/nginx/templates
VOLUME /app/public

COPY "php8.1/etc/" /etc/

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
