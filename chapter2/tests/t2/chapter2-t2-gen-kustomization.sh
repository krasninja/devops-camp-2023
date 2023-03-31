#!/bin/bash
#
# Processes repositories list, generates the ed25519 key for each of them and
# outputs the Kustomization configuration.
set -eo pipefail

readonly DEPLOY_KEY_POSTFIX="deploy-key.pem"
readonly REPO_DIR="repos"
readonly KUSTOMIZATION_FILE="./$REPO_DIR/kustomization.yaml"

if [ $# -eq 0 ]; then
  echo "Usage: chapter2-t2-gen-kustomization.sh [REPO]..."
  exit 1
fi

# Init, prepare kustomize.
mkdir -p repos
cat <<EOF > "$KUSTOMIZATION_FILE"
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

generatorOptions:
  disableNameSuffixHash: true

secretGenerator:
EOF

while (( $# )); do
  repo=$(basename "$1")
  deploy_key="./$REPO_DIR/$repo-$DEPLOY_KEY_POSTFIX"

  # Create deploy key.
  ssh-keygen -t ed25519 -f "$deploy_key" -N '' -m pem -q <<< y > /dev/null 2>&1

  # Append kustomization data.
  cat <<EOF >> "$KUSTOMIZATION_FILE"
  - name: $repo
    namespace: argo-cd
    options:
      labels:
        argocd.argoproj.io/secret-type: repository
    literals:
      - name=$repo
      - url=git@github.com:saritasa-nest/$repo.git
      - type=git
      - project=default
    files:
      - sshPrivateKey=$repo-$DEPLOY_KEY_POSTFIX

EOF

  shift
done

# Generate final output.
kustomize build repos
