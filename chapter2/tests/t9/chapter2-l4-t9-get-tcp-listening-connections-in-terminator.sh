#!/bin/bash
# The solution should always output in the open terminator console even if you close and reopen the terminator window.
set -eou pipefail

trap 'echo ERROR!; echo on line: $LINENO in $0; cat $0 | sed "$LINENO!d"' ERR

readonly SLEEP_TIMEOUT_SEC=2
readonly PORT_START=10000
readonly PORT_END=10100
readonly FILTER_EXPR="( sport >= ${PORT_START} && sport <= ${PORT_END} )"

total_ss_output=$(ss -ltn "${FILTER_EXPR}" --no-header)
echo "Looking for the new listening TCP sockets on ports ${PORT_START}-${PORT_END} range..."

while true; do
  # Compare last tracked connections and current ones. We want to display only new connections.
  ss_output=$(ss -ltn "${FILTER_EXPR}" --no-header)
  ss_diff=$( comm -13 <(echo "${total_ss_output}") <(echo "${ss_output}") )

  # Display diff to active ttys.
  if [[ -n "${ss_diff}" ]]; then
    terminator_pid=$(pgrep terminator)
    readonly terminator_pid
    if [[ -n "${terminator_pid}" ]]; then
      terminator_zsh_pid=$(pgrep -P "${terminator_pid}" zsh)
      readonly terminator_zsh_pid
      $(echo "${ss_diff}" | awk '{ printf "%-20s %-20s\n", $4, $5 }' 2>/dev/null > "/proc/${terminator_zsh_pid}/fd/1") || true
    fi
  fi

  total_ss_output="${ss_output}"
  sleep "${SLEEP_TIMEOUT_SEC}"
done
