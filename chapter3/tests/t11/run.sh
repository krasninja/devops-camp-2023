#!/bin/bash
# The script prepares execution environment for task 11.
set -eou pipefail

if [[ whoami != 'root' ]]; then
  echo 'Please use sudo to run the script' >&2
  exit 1
fi

# Create SSL certificates.
mkdir -p .private
cd .private
mkcert --install && true
mkcert "*.camp-php.local" camp-php.local
cd ..

# Copy PHP files.
mkdir -p /tmp/nginx/reports/
cp ./www/* /tmp/nginx/reports
chown nginx:nginx -R /tmp/nginx/reports/

