#!/bin/bash
# install ssh server
sudo apt update && sudo apt upgrade -y
sudo ufw allow ssh 


# install ansible repo
sudo apt install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update

echo INSTALL PREREQUISITES : git openssh-server
sudo apt-get install  git openssh-server  



sudo apt-get install ansible -y
# install community collections
# ansible-galaxy collection install community.general
# ansible-galaxy collection install community.docker

sudo mkdir /github/
cd /github/
#sudo wget https://github.com/loomanss/ubuntu-install/archive/main.zip
sudo git clone https://github.com/loomanss/ubuntu-install.git
sudo cd /github/ubuntu-install
