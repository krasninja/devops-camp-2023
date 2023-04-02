#!/bin/bash
#
# The script return unique directories of all files (including nested directories).
set -eou pipefail

IFS=$'\n'

#######################################
# Get files directories (including nested directories).
# Arguments:
#   Directory.
# Outputs:
#   Writes directories into stdout.
#######################################
function get_files_directories {
  for file in $(find "$1" -type f 2>/dev/null); do
    echo "${file%/*}"
  done
}

dir=${1?'Usage: [DIR]'}
get_files_directories "${dir}" | sort | uniq

