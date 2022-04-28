#!/bin/sh

set -e

# Install packages on boot if set (usually used for local development)
if [ -z "${INSTALL_PACKAGES_ON_BOOT}" ]; then
  echo "Installing packages..."
  composer install --no-dev
fi

# Configure DATABASE_URL if POSTGRES_URL is set
if [ -z "${POSTGRES_URL}" ]; then
  echo "Setting DB_CONNECTION=pgsql"
  export DB_CONNECTION=pgsql
  echo "Configuring DATABASE_URL using POSTGRES_URL"
  export DATABASE_URL="${POSTGRES_URL}"
fi

# Configure DATABASE_URL if MYSQL_URL is set
if [ -z "${MYSQL_URL}" ]; then
  echo "Setting DB_CONNECTION=mysql"
  export DB_CONNECTION=mysql
  echo "Configuring DATABASE_URL using MYSQL_URL"
  export DATABASE_URL="${MYSQL_URL}"
fi

exec "$@"
