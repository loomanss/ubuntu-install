#!/bin/bash
# install ssh server
sudo apt update -y  && sudo apt upgrade -y
sudo apt install openssh-server -y
sudo systemctl status ssh -y
sudo ufw allow ssh -y

# install ansible
sudo apt install software-properties-common -y
apt-add-repository ppa:ansible/ansible -y
apt-get update -y
apt-get install ansible -y
