#!/bin/bash

# install ssh server
echo update and upgrade
echo -------------------------------------------------------------------------
sudo -i
sudo apt update
sudo apt upgrade -y
sudo ufw allow ssh 
echo
echo
echo installing prerequisites
echo -------------------------------------------------------------------------
sudo apt install software-properties-common git openssh-server -y



git config --global user.email "$1"
git config --global user.name "$2"



echo
echo  disable ipv6 until reboot to speed up :
echo    - apt add repo
echo    - ansible-galaxy
echo -------------------------------------------------------------------------
sudo sysctl net.ipv6.conf.all.disable_ipv6=1
echo 
echo
echo  add repo key
echo -------------------------------------------------------------------------
sudo apt-add-repository ppa:ansible/ansible -y
echo
echo
echo  updating repo
echo -------------------------------------------------------------------------
sudo apt-get update

echo
echo
echo INSTALL ansible
echo -------------------------------------------------------------------------
sudo apt-get install ansible -y
echo
echo
echo INSTALL ansible galaxy community.general 
echo -------------------------------------------------------------------------
ansible-galaxy collection install community.general
echo
echo
echo INSTALL ansible galaxy community.docker 
echo -------------------------------------------------------------------------
ansible-galaxy collection install community.docker



echo
echo
echo INSTALL python argcomplete
echo -------------------------------------------------------------------------
sudo apt install python-argcomplete python3-pip  -y
sudo activate-global-python-argcomplete


echo
echo
echo 
echo download playbook repo
echo -------------------------------------------------------------------------
sudo mkdir -p /share/github
cd /share/github
sudo git clone https://github.com/loomanss/ubuntu-install.git
cd /share/github/ubuntu-install/playbooks/
