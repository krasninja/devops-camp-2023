#!/bin/bash
# The script prepares execution environment for task 11.
set -eou pipefail

# Create SSL certificates.
mkdir -p .private
cd .private
mkcert --install && true
mkcert "*.camp-php.local" camp-php.local
cd ..

# Copy PHP files.
mkdir -p /tmp/nginx/reports/
cp -r ./www/* /tmp/nginx/reports
sudo chown nginx:nginx -R /tmp/nginx/reports/

