#!/bin/bash
#--------------------------------------------------------------------------------
# Apt
#--------------------------------------------------------------------------------
sudo apt update -qy
sudo apt install -y apt-file

#================================================================================
# Python
#================================================================================
sudo apt install -y curl # to download get-pip.py

# --------------------------------------------------------------------------------
# To avoid build-essential : Depends: dpkg-dev (>= 1.17.11) but it is not going to be installed
# https://askubuntu.com/questions/484750/why-build-essential-failed
# --------------------------------------------------------------------------------
sudo apt-get remove --purge libdpkg-perl -y
sudo apt install -y libdpkg-perl

# Ansible dependencies
sudo apt install -y build-essential libssl-dev libffi-dev python-dev python-setuptools cowsay

# --------------------------------------------------------------------------------
# To fix the issue of pip ImportError: cannot import name main
# https://stackoverflow.com/questions/49836676/error-after-upgrading-pip-cannot-import-name-main
# --------------------------------------------------------------------------------
sudo python3 -m pip uninstall -y pip && sudo apt install -y python3-pip --reinstall
#sudo python -m pip uninstall -y pip && sudo apt install -y python-pip --reinstall
#sudo apt install -y python-pip
# --------------------------------------------------------------------------------

# Ubuntu has removed easy_install
# https://launchpad.net/ubuntu/+source/python-setuptools/39.0.1-2
#sudo easy_install pip

# --------------------------------------------------------------------------------
# To avoid ImportError: No module named DistUtilsExtra.command, use package manager
# instead of pip.
# https://askubuntu.com/questions/584857/distutilsextra-problem
# --------------------------------------------------------------------------------
sudo apt install -y python-apt

# --------------------------------------------------------------------------------
# Debian decided to actively exclude distutils from the default python.
# https://github.com/pypa/get-pip/issues/43
# --------------------------------------------------------------------------------
sudo apt-get install -y python3-distutils

# --------------------------------------------------------------------------------
# To avoid ERROR: launchpadlib 1.10.6 requires testresources, which is not installed.
# --------------------------------------------------------------------------------
sudo apt install -y python3-testresources


#================================================================================
# SSH
#================================================================================
sudo apt update
sudo apt install -y openssh-server
sudo systemctl enable --now ssh

#================================================================================
# Misc
#================================================================================
sudo apt install -y gnome-tweak-tool
