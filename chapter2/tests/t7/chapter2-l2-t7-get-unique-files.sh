#!/bin/bash
# The scripts returns the list of unique file names (including nested directories).
set -eou pipefail

IFS=$'\n'

if [[ "${#}" -ne 1 ]]; then
  echo "Usage: [DIR]"
  exit 1
fi

dir="${1}"

if [[ ! -e "${dir}" || ! -d "${dir}" ]]; then
  echo "The '${dir}' does not exist or it is not a directory." >&2
  exit 1
fi

#######################################
# Get files (including nested directories).
# Globals:
#   Directory (dir).
# Outputs:
#   Writes file to stdout.
#######################################
function get_files {
  for file in $(find "${dir}" -type f); do
    echo "${file##*/}"
  done
}

get_files | sort -u

