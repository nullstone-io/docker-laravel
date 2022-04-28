#!/bin/sh

if [ -z "${INSTALL_PACKAGES_ON_BOOT}" ]; then
  echo "Installing packages..."
  composer install --no-dev
fi
