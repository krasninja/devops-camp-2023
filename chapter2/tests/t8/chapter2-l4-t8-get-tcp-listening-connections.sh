#!/bin/bash
#
# The script shows all TCP connections in the port range 10000-10100.
set -eou pipefail

readonly SLEEP_TIMEOUT_SEC=2

readonly PORT_START=10000
readonly PORT_END=10100
readonly FILTER_EXPR="( sport >= ${PORT_START} && sport <= ${PORT_END} )"

total_ss_output=''

#######################################
# Output information about connections.
# Globals:
#   FILTER_EXPR
#   total_ss_output
# Arguments:
#   None
#######################################
function get_connections {
  # Compare last tracked connections and current ones. We want to display only new connections.
  local ss_output=$(ss -ltn "${FILTER_EXPR}" --no-header)
  local diff=$( comm -13 <(echo "${total_ss_output}") <(echo "${ss_output}") )

  # Case when we have no matched connections at all.
  if [[ -z "${ss_output}" ]]; then
    echo "No TCP listening sockets found bound to ports in ${PORT_START}-${PORT_END} range"
    return
  fi

  # Display diff.
  if [[ -n "${diff}" ]]; then
    # Header.
    if [[ -z "${total_ss_output}" ]]; then
      echo 'Local Address:Port   Peer Address:Port'
    fi
    echo "${diff}" | awk '{ printf "%-20s %-20s\n", $4, $5 }'
  fi

  total_ss_output="${ss_output}"
}

while true; do
  get_connections
  sleep "${SLEEP_TIMEOUT_SEC}"
done
