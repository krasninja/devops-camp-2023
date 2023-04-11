#!/bin/bash
# The scripts returns list of files without extension.
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

for file in $(find "${dir}" -type f); do
  # Check if file has extension. If it has - trim it, otherwise return dir.
  file_name="${file##*/}"
  file_dir="${file%/*}"
  file_extension="${file_name%%.*}"
  [[ -n "${file_extension}" ]] && echo "${file_dir}/${file_name%%.*}" || echo "${file_dir}/"
done

