#!/bin/bash
# The script creates private and public keys for camp-php, camp-python sites.
set -eou pipefail

if ! which mkcert > /dev/null 2>&1; then
  echo 'Please install mkcert utility' >&2
  exit 1
fi

mkdir -p .private
cd .private

mkcert --install && true
mkcert "*.camp-php.local" camp-php.local
mkcert "*.camp-python.local" camp-python.local

