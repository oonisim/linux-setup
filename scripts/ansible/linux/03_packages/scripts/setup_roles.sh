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
