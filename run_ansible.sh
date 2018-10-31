#!/usr/bin/env bash
set -eu
DIR=$(realpath $(dirname $0))
cd ${DIR}

#--------------------------------------------------------------------------------
# SSH
#--------------------------------------------------------------------------------
echo "Make sure SSH agent has been executed"
ssh-add

#--------------------------------------------------------------------------------
# Global directories
#--------------------------------------------------------------------------------
export CONF_DIR=${DIR}/conf/ansible
export TOOL_DIR=${DIR}/tools
export SCRIPT_BASE=${DIR}/scripts/ansible
export SCRIPT_SET=linux
export SCRIPT_DIR=${SCRIPT_BASE}/${SCRIPT_SET}

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
for module in $(find ${SCRIPT_DIR} -type d -maxdepth 1 -mindepth 1 | sort)
do
    ${module}/scripts/main.sh \
        ${TARGET_INVENTORY} \
        ${REMOTE_USER}
done
