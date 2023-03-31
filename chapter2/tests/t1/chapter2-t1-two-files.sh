#!/bin/bash
#
# Script processes input files. If file exists - output it, otherwise
# create it with permission 700 with bash64 password.
set -eo pipefail

if [ $# -lt 2 ]; then
  echo "The script requires at least 2 arguments - filenames"
  exit 1
fi

# Iterate thru files.
while (( $# )); do
  file="$1"
  # If exists - show content.
  if [ -e "${file}" ]; then
    cat "${file}"
    echo ''
  # If not - create with random base64 string and permissions rwx------.
  else
    local_file="$(basename "${file}")"
    openssl rand -base64 12 > "${local_file}"
    chmod 700 "${local_file}"
    echo "Created file ${local_file}"
  fi

  shift
done

