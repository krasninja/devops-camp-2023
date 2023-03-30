#!/bin/bash
if [ "$#" -eq 0 ]; then
  echo "Usage: chapter2-t2-gen-kustomization.sh [REPO]..."
  exit 1
fi

readonly DEPLOY_KEY_POSTFIX="deploy-key.pem"

# stop on first error
set -e

# init, prepare kustomize
mkdir -p repos
echo \
"apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

generatorOptions:
  disableNameSuffixHash: true

secretGenerator:"  > ./repos/kustomization.yaml

# iter thru repos
while (( $# )); do
  repo=$(basename $1)
  deploy_key="./repos/$repo-$DEPLOY_KEY_POSTFIX"
  
  # create deploy key
  rm -f $deploy_key
  ssh-keygen -t ed25519 -f $deploy_key -N '' -m pem -q

  # append kustomization data
  echo -e \
"  - name: $repo
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
      - sshPrivateKey=$repo-$DEPLOY_KEY_POSTFIX\n" >> ./repos/kustomization.yaml

  shift
done

kustomize build repos

