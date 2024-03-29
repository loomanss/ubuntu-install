#!/bin/bash

sudo apt-get update
sudo apt-get -y install openssh-server jq curl git 
sudo systemctl enable sshd
sudo systemctl start sshd
# check if ufw is enabled
sudo ufw status
sudo ufw allow ssh
sudo ufw reload
sudo ufw status
