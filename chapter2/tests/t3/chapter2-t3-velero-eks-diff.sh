#!/bin/bash
#
# The script finds namespaces without the backup. The "yq" utility must be installed.
set -eou pipefail

readonly VELERO_CONFIG='https://gist.githubusercontent.com/dmitry-mightydevops/016139747b6cefdc94160607f95ede74/raw/030a82af2489bc353cec370779cfd06852668e29/velero.yaml'
readonly KUBE_NAMESPACES='https://gist.githubusercontent.com/dmitry-mightydevops/297c4e235b61982f21a0bbbf7319ac24/raw/0e57e62984b69ff16c9b9159776e145f6d4feecf/kubernetes-namespaces.txt'

#######################################
# Request URI and checks that content is available.
# The function terminates the script in case of bad status code.
# Arguments:
#   URI.
#######################################
function ensure_uri_exists {
  local status_code=$(curl -I --silent "${1}" | head -n 1 | cut -d' ' -f2)
  if [[ "${status_code}" != 200 ]]; then
    echo "Cannot download URI '${1}', status code ${status_code}." >&2
    exit 1
  fi
}

ensure_uri_exists "${VELERO_CONFIG}"
ensure_uri_exists "${KUBE_NAMESPACES}"

comm -13 \
  <(curl --silent "${VELERO_CONFIG}" | yq '.spec.source.helm.values' -r | yq '.schedules[].template.includedNamespaces[]' -r | sort | uniq) \
  <(curl --silent "${KUBE_NAMESPACES}" | sort | uniq) \
  | sed 's/^/- /'

