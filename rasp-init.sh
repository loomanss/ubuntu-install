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
sudo apt install software-properties-common git openssh-server  -y
