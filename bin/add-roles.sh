#!/usr/bin/env bash

set -eu

dir=$(dirname ${0})

${dir}/utils/idam-add-role.sh "ccd-import"
${dir}/utils/idam-add-role.sh "caseworker"
${dir}/utils/idam-add-role.sh "caseworker-civil"

# User used during the CCD import and ccd-role creation
${dir}/utils/idam-create-caseworker.sh "ccd.docker.default@hmcts.net" "ccd-import"

${dir}/utils/ccd-add-role.sh "caseworker-civil"

roles=("solicitor" "systemupdate")
for role in "${roles[@]}"
do
  ${dir}/utils/idam-add-role.sh "caseworker-civil-${role}"
  ${dir}/utils/ccd-add-role.sh "caseworker-civil-${role}"
done

roles=("caa" "case-manager" "finance-manager" "organisation-manager" "user-manager")
for role in "${roles[@]}"
do
  ${dir}/utils/idam-add-role.sh "pui-${role}"
done
