#!/bin/bash
#
# The script finds namespaces without the backup. The "yq" utility must be installed.
set -eou pipefail

readonly VELERO_CONFIG='https://gist.githubusercontent.com/dmitry-mightydevops/016139747b6cefdc94160607f95ede74/raw/030a82af2489bc353cec370779cfd06852668e29/velero.yaml'
readonly KUBE_NAMESPACES='https://gist.githubusercontent.com/dmitry-mightydevops/297c4e235b61982f21a0bbbf7319ac24/raw/0e57e62984b69ff16c9b9159776e145f6d4feecf/kubernetes-namespaces.txt'

comm -13 \
  <(curl --silent "${VELERO_CONFIG}" | yq '.spec.source.helm.values' -r | yq '.schedules[].template.includedNamespaces[]' -r | sort | uniq) \
  <(curl --silent "${KUBE_NAMESPACES}" | sort | uniq) \
  | sed 's/\([[:alnum:]]*\)/- \1/'

