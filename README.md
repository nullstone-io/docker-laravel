# nullstone/laravel

Laravel Base Image that is optimized for production and configured to operate locally the same way.
This image is very opinionated; however, not restrictive.

## Server

This image uses alpine to run laravel using [nginx](https://www.nginx.com/) and [php-fpm](https://php-fpm.org/).
This image uses  [supervisord](http://supervisord.org/) to manage both processes.

The logs from each of these is configured to emit to stdout/stderr.

## Nginx sidecar

This image is configured to easily connect a sidecar container running nginx.
By doing so, nginx can serve static assets with php requests forwarded to this container.

There are 3 volumes exposed in this image that are shared with the nginx sidecar.
These volumes automatically configure nginx to serve static assets and php properly.

Here is an example `docker-compose.yml` to configure for local development:
```
version: "3.8"

services:
  nginx:
    image: nginx:stable-alpine
    volumes:
      - app-public:/app/public
      - nginx-confd:/etc/nginx/conf.d
      - nginx-templates:/etc/nginx/templates:ro
    ports:
      - "3000:80"
    environment:
      - WEBAPP_ADDR=app:9000
    depends_on:
      - app

  app:
    build: .
    entrypoint: /docker-entrypoint.d/local.sh
    command: php-fpm8
    volumes:
      - "vendor:/app/vendor"
      - ".:/app"
      - app-public:/app/public
      - nginx-confd:/etc/nginx/conf.d
      - nginx-templates:/etc/nginx/templates
    environment:
      - APP_ENV=local
      - APP_KEY=${APP_KEY}
      - APP_DEBUG=true

volumes:
  vendor:
  app-public:
  nginx-confd:
  nginx-templates:
```

## Add redis

Update `docker-compose.yml`.
```
services:
  app:
    ...
    environment:
      ...
      - CACHE_DRIVER=redis
      - REDIS_URL=tcp://redis:6379/0
  ...
  redis:
    image: redis:6-alpine
    ports:
      - "6379:6379"
```

Install redis to `Dockerfile`.
```dockerfile
RUN apk add --no-cache pcre-dev $PHPIZE_DEPS \
  && pecl install redis \
  && rm -rf /tmp/pear \
  && docker-php-ext-enable redis.so
```
