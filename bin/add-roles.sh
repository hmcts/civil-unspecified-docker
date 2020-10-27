#!/usr/bin/env bash

set -eu

dir=$(dirname ${0})

${dir}/utils/idam-add-role.sh "ccd-import"

# User used during the CCD import and ccd-role creation
${dir}/utils/idam-create-caseworker.sh "ccd.docker.default@hmcts.net" "ccd-import"

jq -r '[(.[] | .roles | split(",")) | .[] ] | unique[]' ${dir}/users.json | while read args; do
  ${dir}/utils/idam-add-role.sh "$args"
  ${dir}/utils/ccd-add-role.sh "$args"
done
