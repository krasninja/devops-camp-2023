#!/bin/bash
#
# The scripts returns the list of unique file names (including nested directories).
set -eou pipefail

IFS=$'\n'

#######################################
# Get files (including nested directories).
# Arguments:
#   Directory.
# Outputs:
#   Writes file to stdout.
#######################################
function get_files {
  for file in $(find "$1" -type f 2>/dev/null); do
    echo "${file##*/}"
  done
}

dir=${1?'Usage: [DIR]'}
get_files "${dir}" | sort | uniq

