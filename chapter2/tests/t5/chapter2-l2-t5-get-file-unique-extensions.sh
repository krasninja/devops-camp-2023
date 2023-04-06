#!/bin/bash
#
# The script gets a directory as an argument and returns a list of unique extensions of all files (including in the nested directories).
set -eou pipefail

IFS=$'\n'

dir="${1}"

if [[ ! -e "${dir}" || ! -d "${dir}" ]]; then
  echo "The '${dir}' does not exist or it is not a directory." >&2
  exit 1
fi

#######################################
# Get directory files extensions (including nested directories).
# Arguments:
#   Directory.
# Outputs:
#   Writes extension into stdout.
#######################################
function get_files_extensions {
  local dir="${1}"
  for file in $(find "${dir}" -type f 2>/dev/null); do
    # Check if file has extension.
    [[ "${file}" =~ \.[^\/]+$ ]] && echo "${file##*.}" || continue
  done
}

get_files_extensions "${dir}" | sort | uniq

