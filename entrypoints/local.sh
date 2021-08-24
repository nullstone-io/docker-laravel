#!/bin/sh

set -e

echo "Installing packages..."
composer install --no-dev

exec "$@"
