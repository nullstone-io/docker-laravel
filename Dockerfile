FROM php:8-alpine

RUN apk --update add nginx supervisor composer php8-fpm

COPY etc/ /etc/

# Configure php-fpm
RUN mkdir -p /run/php/
RUN touch /run/php/php-fpm.pid
RUN touch /run/php/php-fpm.sock

# Configure nginx
RUN mkdir -p /run/nginx/
RUN touch /run/nginx/nginx.pid

# Configure Laravel
ONBUILD WORKDIR /app
ONBUILD ENV LOG_CHANNEL=stderr

CMD supervisord -c /etc/supervisor.d/supervisord.ini
