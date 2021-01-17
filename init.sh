#!/bin/bash
# install ssh server
sudo apt update -y  && sudo apt upgrade -y
sudo apt install openssh-server -y
sudo systemctl status ssh -y
sudo ufw allow ssh -y

#install git
sudo apt install git -y

# install ansible
sudo apt install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt-get install ansible -y
# install community collections
ansible-galaxy collection install community.general
ansible-galaxy collection install community.docker

sudo mkdir /github/
cd /github/
#sudo wget https://github.com/loomanss/ubuntu-install/archive/main.zip
sudo git clone https://github.com/loomanss/ubuntu-install.git
sudo cd /github/ubuntu-install
