#!/bin/bash


#wget  -qO -  https://raw.githubusercontent.com/loomanss/ubuntu-install/main/init-2.sh | bash


sudo apt-get update
sudo apt-get -y install openssh-server jq curl git 
sudo systemctl enable sshd
sudo systemctl start sshd
# check if ufw is enabled
sudo ufw status
sudo ufw allow ssh
sudo ufw reload
sudo ufw status


# URLFILE=https://bitbucket.org/loomanss/image-store/raw/f7931cd05d705e41679a82261d9e362093565583/scripts/1_install_vault.sh
