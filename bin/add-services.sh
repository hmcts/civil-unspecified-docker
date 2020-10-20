#!/usr/bin/env bash

set -eu

dir=$(dirname ${0})

${dir}/utils/idam-create-service.sh "ccd_gateway" "ccd_gateway" "ccd_gateway_secret" "http://localhost:3451/oauth2redirect"

${dir}/utils/idam-create-service.sh "unspec" "unspec" "OOOOOOOOOOOOOOOO" "https://localhost:9000/oauth2/callback"

${dir}/utils/idam-create-service.sh "xui_webapp" "xui_webapp" "OOOOOOOOOOOOOOOO" "http://localhost:3333/oauth2/callback" "false" "profile openid roles manage-user create-user"

${dir}/utils/idam-create-service.sh "xui_webapp_mo" "xui_webapp_mo" "OOOOOOOOOOOOOOOO" "http://localhost:3000/oauth2/callback"
