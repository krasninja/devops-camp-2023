#!/bin/bash
#
# The script gets a directory as an argument and returns a list of unique extensions of all files (including in the nested directories).
set -eou pipefail

IFS=$'\n'

#######################################
# Get directory files extensions (including nested directories).
# Arguments:
#   Directory.
# Outputs:
#   Writes extension into stdout.
#######################################
function get_files_extensions {
  for file in $(find "$1" -type f 2>/dev/null); do
    # Check if file has extension.
    [[ "${file}" =~ \.[^\/]+$ ]] && echo "${file##*.}" || continue
  done
}

dir=${1?'Usage: [DIR]'}
get_files_extensions "${dir}" | sort | uniq
