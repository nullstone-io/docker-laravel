#!/bin/sh

set -e

# Install dependencies on boot
if [ -f "composer.lock" ]; then
  echo "Installing dependencies..."
  composer install --no-dev
fi

# Set laravel APP_ENV to NULLSTONE_ENV if set
if [ -n "${NULLSTONE_ENV}" ]; then
  export APP_ENV="${NULLSTONE_ENV}"
fi

# Configure DATABASE_URL if POSTGRES_URL is set
if [ -n "${POSTGRES_URL}" ]; then
  echo "Setting DB_CONNECTION=pgsql"
  export DB_CONNECTION=pgsql
  echo "Configuring DATABASE_URL using POSTGRES_URL"
  export DATABASE_URL="${POSTGRES_URL}"
fi

# Configure DATABASE_URL if MYSQL_URL is set
if [ -n "${MYSQL_URL}" ]; then
  echo "Setting DB_CONNECTION=mysql"
  export DB_CONNECTION=mysql
  echo "Configuring DATABASE_URL using MYSQL_URL"
  export DATABASE_URL="${MYSQL_URL}"
fi

exec "$@"
