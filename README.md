# nullstone/laravel

Laravel Base Image that is optimized for production and configured to operate locally the same way.
This image is very opinionated; however, not restrictive.

This image is configured with:
- Server optimized for [php-fpm](https://php-fpm.org/).
- Static assets and files are automatically added using `ONBUILD` during your docker build process.
- When making code changes, no need to rebuild/restart your container.
- Logs are emitted to stdout/stderr.
- The resulting image is small (~37mb).
- Preconfigured to attach [nginx](https://www.nginx.com/) sidecar container. See below.

## Local Development

When developing locally, it's common to add/update/remove packages to your application.
With the `INSTALL_PACKAGES_ON_BOOT=true` env var set, restart your docker container to update packages. 
They will be installed upon boot of the docker container.

## Nginx sidecar

This image is configured to easily connect a sidecar container running nginx.
By doing so, nginx can serve static assets with php requests forwarded to this container.

There are 3 volumes exposed in this image that are shared with the nginx sidecar.
These volumes automatically configure nginx to serve static assets and php properly.

See [examples/basic/docker-compose.yml](examples/basic/docker-compose.yml) for working example for local development.

## Swap mysql for postgresql

Update `docker-compose.yml`. See full example at [examples/postgres/docker-compose.yml](examples/postgres/docker-compose.yml).
```
services:
  app:
    ...
    environment:
      ...
      - DB_CONNECTION=pgsql
      - DATABASE_URL=postgres://acme:acme@db:5432/acme
  ...
  db:
    image: postgres
    ports:
      - 5432:5432
    environment:
      - POSTGRES_USER=acme
      - POSTGRES_PASSWORD=acme
      - POSTGRES_DB=acme
```


## Add redis

Update `docker-compose.yml`. See full example at [examples/redis/docker-compose.yml](examples/redis/docker-compose.yml).
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
