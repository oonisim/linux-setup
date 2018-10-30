#!/usr/bin/env bash
set -eu
DIR=$(realpath $(dirname $0))
cd ${DIR}

#--------------------------------------------------------------------------------
# Target environment/inventory and Ansibe remote_user to use
#--------------------------------------------------------------------------------
if [ -z ${TARGET_INVENTORY+x} ]; then
    echo "What is TARGET_INVENTORY?"
    read TARGET_INVENTORY
else
    echo "TARGET_INVENTORY is ${TARGET_INVENTORY}"
fi

if [ -z ${REMOTE_USER+x} ]; then
    echo "What is REMOTE_USER?"
    read REMOTE_USER
else
    echo "REMOTE_USER is ${REMOTE_USER}"
fi

#--------------------------------------------------------------------------------
# Run setup
#--------------------------------------------------------------------------------
${DIR}/maintenance.sh
for module in $(find ./deployment/ansible/linux -type d -maxdepth 1 -mindepth 1 | sort)
do
    ${module}/scripts/main.sh \
        ${TARGET_INVENTORY} \
        ${REMOTE_USER}

done
