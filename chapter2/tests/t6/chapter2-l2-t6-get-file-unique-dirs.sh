#!/bin/bash
# The script return unique directories of all files (including nested directories).
set -eou pipefail

IFS=$'\n'

if [ "${#}" -ne 1 ]; then
  echo "Usage: [DIR]"
  exit 1
fi

dir="${1}"

if [[ ! -e "${dir}" || ! -d "${dir}" ]]; then
  echo "The '${dir}' does not exist or it is not a directory." >&2
  exit 1
fi

#######################################
# Get files directories (including nested directories).
# Globals:
#   Directory.
# Outputs:
#   Writes directories into stdout.
#######################################
function get_files_directories {
  for file in $(find "${dir}" -type f); do
    echo "${file%/*}"
  done
}

get_files_directories | sort -u

