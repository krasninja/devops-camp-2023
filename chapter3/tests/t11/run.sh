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
echo "Copy files"
mkdir -p /tmp/nginx/reports/
sudo cp -r ./www/* /tmp/nginx/reports
sudo chown nginx:nginx -R /tmp/nginx/reports/

# Start Nginx and PHP FPM.
echo "Start Nginx and PHP FPM"
sudo killall -wq php-fpm && true
sudo killall -wq nginx && true
sudo php-fpm --php-ini "$(pwd)/php.ini" -y "$(pwd)/php-fpm.conf" &
sudo nginx -c "$(pwd)/nginx.conf" &

# Requests.
echo "Request reports"
sleep 2
curl https://camp-php.local/reports/fast
curl https://camp-php.local/reports/slow
