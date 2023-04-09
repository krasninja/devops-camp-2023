#!/bin/bash
#
# The script shows all TCP connections in the port range 10000-10100.
set -eou pipefail

readonly PORT_START=10000
readonly PORT_END=10100
readonly FILTER_EXPR="( sport >= ${PORT_START} && sport <= ${PORT_END} )"

#######################################
# Output information about connections.
# Globals:
#   FILTER_EXPR
# Arguments:
#   None
#######################################
function get_connections {
  local sockets_output=$(ss -ltn "${FILTER_EXPR}" --no-header)
  if [[ -n "${sockets_output}" ]]; then
    echo 'Local Address:Port   Peer Address:Port'
    echo "${sockets_output}" | awk '{ printf "%-20s %-20s\n", $4, $5 }'
  else
    echo 'No TCP listening sockets found bound to ports in 10000-10100 range'
  fi
}

while true; do
  output=$(get_connections)
  clear
  echo "${output}"
  sleep 1
done

