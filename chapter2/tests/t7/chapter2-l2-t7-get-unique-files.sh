#!/bin/bash
#
# The scripts returns the list of unique file names (including nested directories).
set -eou pipefail

IFS=$'\n'

dir="${1}"

if [[ ! -e "${dir}" || ! -d "${dir}" ]]; then
  echo "The '${dir}' does not exist or it is not a directory." >&2
  exit 1
fi

#######################################
# Get files (including nested directories).
# Arguments:
#   Directory.
# Outputs:
#   Writes file to stdout.
#######################################
function get_files {
  local dir="${1}"
  for file in $(find "${dir}" -type f 2> /dev/null); do
    echo "${file##*/}"
  done
}

get_files "${dir}" | sort | uniq

