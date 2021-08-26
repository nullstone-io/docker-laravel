FROM php:8-alpine

RUN apk --update add composer \
  php8-fpm php8-session php8-openssl php8-tokenizer \
  php8-pgsql php-mysqli

COPY etc/ /etc/

# Copy in entrypoints
COPY entrypoints/ /entrypoints/
RUN chmod +x /entrypoints/*.sh

# Configure Laravel
ONBUILD WORKDIR /app
ONBUILD COPY --chown=nobody:nobody . .
ONBUILD ENV LOG_CHANNEL=stderr

EXPOSE 9000
CMD php-fpm8
