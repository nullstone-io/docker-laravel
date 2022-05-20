# nullstone/laravel

Laravel Base Image that is configured with different image tags for local and production.
This image is very opinionated; however, not restrictive.

## Quick Reference

- Maintained by
  [Nullstone](https://nullstone.io)
- Where to get help
  [Nullstone Slack](https://join.slack.com/t/nullstone-community/signup)

## Supported Tags and respective `Dockerfile` links

- [local](local.Dockerfile)
- [latest](Dockerfile)

## Production

The production image is configured with:
- Server optimized for [php-fpm](https://php-fpm.org/).
- Logs are emitted to stdout/stderr.
- The resulting image is small (~37mb).
- Preconfigured to attach [nginx](https://www.nginx.com/) sidecar container. See below.

## Local Image

The local image is configured with:
- Server is run with `php artisan serve`
- Hot-reloading and debugging is enabled
- Logs are emitted to stdout/stderr

## Automatic Env Variables

On boot, this docker image automatically configures several environment variables. 
1. If `POSTGRES_URL` is set, `DB_CONNECTION=pgsql` and `DATABASE_URL=$POSTGRES_URL`.
2. If `MYSQL_URL` is set, `DB_CONNECTION=mysql` and `DATABASE_URL=$MYSQL_URL`.
3. If `NULLSTONE_ENV` is set, `APP_ENV=$NULLSTONE_ENV`.

## Local Development

When developing locally, it's common to add/update/remove packages to your application.
After updating your dependencies, restart your docker container.
On boot, the dependencies will be installed with `composer install`.

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
      - MYSQL_URL=mysql://acme:acme@db:3306/acme
  ...
  db:
    image: mysql
    ports:
      - "3306:3306"
    environment:
      - MYSQL_USER=acme
      - MYSQL_PASSWORD=acme
      - MYSQL_DATABASE=acme
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
