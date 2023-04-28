#!/bin/bash
# The script starts nginx in docker and another container that runs tcpdum against nginx.
set -eou pipefail

readonly CONTAINER_NAME="nginx"
readonly DEBUG_CONTAINER_NAME="nginx-debug"

docker start "${CONTAINER_NAME}" || docker run --rm --publish 8080:80 -d --name "${CONTAINER_NAME}" nginx
docker run --rm -it --name "${DEBUG_CONTAINER_NAME}" --network container:"${CONTAINER_NAME}" nixery.dev/tcpdump tcpdump -i eth0 -A -nn port 80

