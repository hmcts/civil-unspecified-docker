#!/usr/bin/env bash

set -eu

dir=$(dirname ${0})

${dir}/utils/idam-add-role.sh "ccd-import"
${dir}/utils/idam-add-role.sh "caseworker"
${dir}/utils/idam-add-role.sh "caseworker-cmc"

# User used during the CCD import and ccd-role creation
${dir}/utils/idam-create-caseworker.sh "ccd.docker.default@hmcts.net" "ccd-import"

${dir}/utils/ccd-add-role.sh "caseworker-cmc"

roles=("solicitor, systemupdate")
for role in "${roles[@]}"
do
  ${dir}/utils/idam-add-role.sh "caseworker-cmc-${role}"
  ${dir}/utils/ccd-add-role.sh "caseworker-cmc-${role}"
done
