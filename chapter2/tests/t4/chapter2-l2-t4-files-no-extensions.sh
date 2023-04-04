#!/bin/bash
#
# The scripts returns list of files without extension.
set -eou pipefail

IFS=$'\n'

dir=${1?"Usage: [DIR]"}
for file in $(find "${dir}" -type f 2> /dev/null); do
  echo "${file%.*}"
done

