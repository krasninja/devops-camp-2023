#!/bin/bash

# stop on first error
set -e

# validate
if [ "$#" -lt 2 ]; then
  echo "The script requires at least 2 arguments - filenames"
  exit 1
fi

# iterate thru files
while (( $# )); do
  file=$(basename $1)
  # if exists - show content
  if [ -e $file ]; then
    cat $file
  # if not - create with random base64 string and permissions rwx------
  else
    cat /dev/random | tr -cd '[[:alnum:]]' | head -c 12 | base64 > $file
    chmod 700 $file
    echo "Created file $file"
  fi

  shift
done

