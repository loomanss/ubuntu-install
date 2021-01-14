#!/bin/bash
# install ssh server
sudo apt update -y  && sudo apt upgrade -y
sudo apt install openssh-server
sudo systemctl status ssh
sudo ufw allow ssh

# install ansible
sudo apt install software-properties-common -y
apt-add-repository ppa:ansible/ansible -y
apt-get update
apt-get install ansible -y
