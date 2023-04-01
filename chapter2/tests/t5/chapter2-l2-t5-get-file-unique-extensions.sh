#!/bin/bash
#
# The script gets a directory as an argument and returns a list of unique extensions of all files (including in the nested directories).
set -eou pipefail

IFS=$'\n'

#######################################
# Get files extensions (including directories).
# Arguments:
#   Directory.
# Outputs:
#   Writes extensoin to stdout.
#######################################
function get_files_extensions {
  for file in $(find "$1" -type f 2>/dev/null); do
    echo "${file##*.}"
  done
}

dir=${1?'Usage: [DIR]'}
get_files_extensions "${dir}" | sort | uniq

