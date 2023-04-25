#!/bin/bash
# The script prepares execution environment for task 12.
set -eou pipefail

# Create SSL certificates.
mkdir -p .private
cd .private
mkcert --install && true
mkcert "*.camp-python.local" camp-python.local
cd ..

# Copy root static files.
echo "Copy files"
sudo mkdir -p /tmp/nginx/
sudo cp ./50x.html /tmp/nginx
sudo chown nginx:nginx /tmp/nginx/50x.html

# Start Nginx and uWSGI.
echo "Start Nginx and uWSGI"
sudo pkill -f uwsgi -9 && true
sudo killall -wq nginx && true
"${PYENV_VIRTUAL_ENV}/bin/uwsgi" --chdir "$(pwd)/app" --ini ./app/app.ini &
sudo nginx -c "$(pwd)/nginx.conf" &

# Requests.
echo "Request reports"
http GET https://camp-python.local/changelog
http POST https://camp-python.local/changelog changelog="lecture about pycamp"
