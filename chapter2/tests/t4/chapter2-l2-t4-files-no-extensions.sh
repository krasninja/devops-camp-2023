#!/bin/bash
#
# The scripts returns list of files without extension.

file=${1?"Usage: [DIR]"}
for file in $(find "${file}" -type f 2>/dev/null); do echo "${file%.*}"; done

