#!/usr/bin/env bash

./ccd enable backend frontend dm-store sidam sidam-local sidam-local-ccd xui unspec docmosis camunda
./ccd disable sidam sidam-local sidam-local-ccd

root_dir=$(realpath $(dirname ${0})/..)

sed  -i '' -e '/IDAM_STUB_SERVICE_NAME/s/^#//g' ${root_dir}/.env
sed  -i '' -e '/IDAM_STUB_LOCALHOST/s/^#//g' ${root_dir}/.env

sed  -i '' -e '/#export IDAM_STUB_LOCALHOST/s/^#//g' ${root_dir}/bin/utils/ccd-import-definition.sh

sed -i '' -e 's/      idam-api:/      ccd-test-stubs-service:/g' ${root_dir}/compose/backend.yml
sed -i '' -e '/#    volumes:/s/^#//g' ${root_dir}/compose/backend.yml
sed -i '' -e '/idam_get_details.json/s/^#//g' ${root_dir}/compose/backend.yml
sed -i '' -e '/idam_get_userinfo.json/s/^#//g' ${root_dir}/compose/backend.yml




#sed -i '' -e '/idam_get_details.json/s/^/#/g' compose/backend.yml
