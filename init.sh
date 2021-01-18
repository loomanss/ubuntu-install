#!/bin/bash
# install ssh server
echo update & upgrade
echo -------------------------------------------------------------------------
sudo apt update
sudo apt upgrade -y
sudo ufw allow ssh 
echo
echo
echo installing prerequisites
echo -------------------------------------------------------------------------
sudo apt install software-properties-common git openssh-server  -y

echo 
echo
echo  add repo key
echo -------------------------------------------------------------------------
# sudo apt-add-repository ppa:ansible/ansible -y
echo
echo
echo  updating repo
echo -------------------------------------------------------------------------
sudo apt-get update

echo INSTALL ansible
echo -------------------------------------------------------------------------
sudo apt-get install ansible -y
# install community collections
# ansible-galaxy collection install community.general
# ansible-galaxy collection install community.docker
echo 
echo download playbook repo
echo -------------------------------------------------------------------------
sudo mkdir /github/
cd /github/
#sudo wget https://github.com/loomanss/ubuntu-install/archive/main.zip
sudo git clone https://github.com/loomanss/ubuntu-install.git
cd /ubuntu-install/playbooks/
