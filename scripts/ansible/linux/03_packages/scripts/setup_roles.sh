#!/bin/bash
_DIR=$(realpath $(dirname $0))
_ROLE_DIR="${_DIR}/../plays/roles"

roles=(
    "gantsign.intellij"
    "cmprescott.chrome"
    "vmware.vmware-workstation"
)

for role in "${roles[@]}"
do
    ansible-galaxy install --roles-path ${_ROLE_DIR} ${role}
done


mkdir -p oefenweb_r              && curl -L https://github.com/Oefenweb/ansible-r/tarball/master              | tar -xz --overwrite --strip 1 -C oefenweb_r
mkdir -p oefenweb_rstudio_server && curl -L https://github.com/Oefenweb/ansible-rstudio-server/tarball/master | tar -xz --overwrite --strip 1 -C oefenweb_rstudio_server
