# nullstone/laravel

Laravel Base Image that is optimized for production and configured to operate locally the same way.
This image is very opinionated; however, not restrictive.

## Server

This image uses alpine to run laravel using [nginx](https://www.nginx.com/) and [php-fpm](https://php-fpm.org/).
This image uses  [supervisord](http://supervisord.org/) to manage both processes.

The logs from each of these is configured to emit to stdout/stderr.

