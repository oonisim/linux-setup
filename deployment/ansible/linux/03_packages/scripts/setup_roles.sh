#!/bin/bash
_DIR=$(realpath $(dirname $0))
_ROLE_DIR="${_DIR}/plays/roles}"

ansible-galaxy install --roles-path ${_ROLE_DIR}/roles gantsign.intellij
ansible-galaxy install --roles-path ${_ROLE_DIR}/roles cmprescott.chrome
