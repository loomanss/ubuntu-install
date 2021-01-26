#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi


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
echo
echo
echo extend lifetime os SD card by disabling and removing swap files 
echo -------------------------------------------------------------------------
sudo systemctl disable dphys-swapfile.service
sudo dphys-swapfile swapoff 
sudo dphys-swapfile uninstall
