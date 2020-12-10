#!/usr/bin/env bash

set -eu

./ccd enable backend frontend dm-store sidam sidam-local sidam-local-ccd xui unspec docmosis camunda

if [ ${IDAM_STUB_ENABLED:-false} == "true" ]; then
  ./ccd disable sidam sidam-local sidam-local-ccd

  sed  -i '' -e '/IDAM_STUB_SERVICE_NAME/s/^#//g' .env
  sed  -i '' -e '/IDAM_STUB_LOCALHOST/s/^#//g' .env

  sed  -i '' -e '/#export IDAM_STUB_LOCALHOST/s/^#//g' bin/utils/ccd-import-definition.sh

  sed -i '' -e 's/      idam-api:/      ccd-test-stubs-service:/g' compose/backend.yml
  sed -i '' -e '/#    volumes: #comment/s/^#//g' compose/backend.yml
  sed -i '' -e '/idam_get_details.json/s/^#//g' compose/backend.yml
  sed -i '' -e '/idam_get_userinfo.json/s/^#//g' compose/backend.yml
  sed -i '' -e '/idam_stub_get_userinfo_post_custom.json/s/^#//g' compose/backend.yml
else
  sed  -i '' -e '/IDAM_STUB_SERVICE_NAME/s/^/#/g' .env
  sed  -i '' -e '/IDAM_STUB_LOCALHOST/s/^/#/g' .env

  sed  -i '' -e '/export IDAM_STUB_LOCALHOST/s/^/#/g' bin/utils/ccd-import-definition.sh

  sed -i '' -e 's/      ccd-test-stubs-service:/      idam-api:/g' compose/backend.yml
  sed -i '' -e '/    volumes: #comment/s/^/#/g' compose/backend.yml
  sed -i '' -e '/idam_get_details.json/s/^/#/g' compose/backend.yml
  sed -i '' -e '/idam_get_userinfo.json/s/^/#/g' compose/backend.yml
  sed -i '' -e '/idam_stub_get_userinfo_post_custom.json/s/^/#/g' compose/backend.yml
fi

./ccd compose up -d
