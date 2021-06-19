#!/bin/bash
#--------------------------------------------------------------------------------
# Run on the Ansible target machine.
# Setup the REMOTE_USER that Ansible master use to ssh-into the target.
#--------------------------------------------------------------------------------
set -u

USER='ansible'
GROUP='ansible'


echo "--------------------------------------------------------------------------------"
echo " Install pre-requisite packages for Ansible on master (Not target)...           "
echo "--------------------------------------------------------------------------------"
system=$(uname)
if [ "$system" == "Linux" ]; then
    #lsb_release may not be installed in RedHat/CentOS
    #distro=$(lsb_release -i)
    distro=$(cat /etc/os-release | grep '^NAME=' | sed -n 's/^NAME=\"\(.*\)\"$/\1/p')
    if [[ ${distro:0:3} == "Ubu" ]] || [[ $distro == "Deb" ]] ;then
      # 'sudo' in Debian/Ubuntu
      # 'wheel' in Fedora/RHEL/CentOS
      SUDO_GROUP='sudo'
    elif [[ ${distro:0:3} == "Red" ]] || [[ $distro == "Cen" ]] ;then
      SUDO_GROUP='wheel'
    else
        msg_exit "Your linux system was not tested"
        exit -1
    fi
fi


#--------------------------------------------------------------------------------
# Account setup
#--------------------------------------------------------------------------------
if [ $(getent group ${GROUP}) ]; then
  echo "group ${GROUP} exists."
else
  sudo groupadd ${GROUP}
fi
if [ $(getent passwd ${USER}) ]; then
  echo "user ${USER} exists."
else
  echo "Creating the Ansible account ${USER} in the group ${GROUP}..."
  sudo useradd -m -s /bin/bash -G ${SUDO_GROUP} -g ${GROUP} ${USER}
fi

#--------------------------------------------------------------------------------
# SSH public authentication setup
#--------------------------------------------------------------------------------
echo "Provide public key text of the keypair that the ${USER} account to use to ssh login"
read key

AUTH_KEY_DIR="$(sudo -i -u ${USER} pwd)/.ssh"
AUTH_KEY_FILE="${AUTH_KEY_DIR}/authorized_keys"
sudo -i -u ${USER} mkdir -p ${AUTH_KEY_DIR}
sudo -i -u ${USER} touch    ${AUTH_KEY_FILE}

sudo -i -u ${USER} grep -q -F "${key}" ${AUTH_KEY_FILE}
if [ $? -ne 0  ]; then
   sudo -i -u ${USER} /bin/bash -c "echo ${key} >> ${AUTH_KEY_FILE}"
fi
sed -i -e '$a\' ${AUTH_KEY_FILE}
sudo -i -u ${USER} chmod -R go-rwx ${AUTH_KEY_DIR}

#--------------------------------------------------------------------------------
# Sudoers setup
#--------------------------------------------------------------------------------
echo "${USER} ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/${USER}

echo "done"
