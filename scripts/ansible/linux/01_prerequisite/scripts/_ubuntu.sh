#!/bin/bash
#--------------------------------------------------------------------------------
# Apt
#--------------------------------------------------------------------------------
sudo apt-get update -qy
sudo apt-update -y
sudo apt-get install -y apt-file

#--------------------------------------------------------------------------------
# Python
#--------------------------------------------------------------------------------
sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev python-setuptools cowsay
sudo apt-get install -y python-pip
# Ubuntu has removed easy_install
# https://launchpad.net/ubuntu/+source/python-setuptools/39.0.1-2
#sudo easy_install pip

#--------------------------------------------------------------------------------
# SSH
#--------------------------------------------------------------------------------
sudo apt-get update
sudo apt-get install -y openssh-server
sudo systemctl enable --now ssh
