FROM php:8-alpine

RUN apk --update add nginx supervisor composer \
  php8-fpm php8-session php8-openssl php8-tokenizer

COPY etc/ /etc/

# Copy in entrypoints
COPY entrypoints/ /entrypoints/
RUN chmod +x /entrypoints/*.sh

# Configure Laravel
ONBUILD WORKDIR /app
ONBUILD COPY . .
ONBUILD ENV LOG_CHANNEL=stderr

EXPOSE 80
CMD supervisord -c /etc/supervisord.conf
