#!/usr/bin/env bash

set -eu

if [ "${ENVIRONMENT:-local}" != "local" ]; then
  exit 0;
fi

dir=$(dirname ${0})

ID=${1}

apiToken=$(${dir}/idam-authenticate.sh "${IDAM_ADMIN_USER}" "${IDAM_ADMIN_PASSWORD}")

echo -e "\nCreating IDAM role: ${ID}"

STATUS=$(curl --silent --output /dev/null --write-out '%{http_code}' -H 'Content-Type: application/json' -H "Authorization: AdminApiAuthToken ${apiToken}" \
  ${IDAM_API_BASE_URL:-http://localhost:5000}/roles -d '{
  "id": "'${ID}'",
  "name": "'${ID}'",
  "description": "'${ID}'",
  "assignableRoles": [ ],
  "conflictingRoles": [ ]
}')
# update assignable roles for prd-admin
#  "assignableRoles": ["caseworker","caseworker-divorce","caseworker-divorce-solicitor","caseworker-divorce-financialremedy","caseworker-divorce-financialremedy-solicitor","caseworker-probate","caseworker-ia","caseworker-probate-solicitor","caseworker-publiclaw","caseworker-ia-legalrep-solicitor","caseworker-publiclaw-solicitor","caseworker-civil","caseworker-civil-solicitor","caseworker-caa","xui-approver-userdata","pui-caa","prd-admin","pui-case-manager","pui-finance-manager","pui-organisation-manager","pui-user-manager"],
if [ $STATUS -eq 201 ]; then
  echo "Role created sucessfully"
elif [ $STATUS -eq 409 ]; then
  echo "Role already exists!"
else
  echo "ERROR: HTTPCODE = $STATUS"
  exit 1
fi
