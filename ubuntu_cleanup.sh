#!/bin/bash
# wget -qO - https://raw.githubusercontent.com/loomanss/ubuntu-install/main/ubuntu_cleanup.sh | bash
# script to remove packages from 20.04 desktop

message() { echo -e "\e[1;32m\n${1}\n\e[0m"; }
warning() { echo -e "\e[1;33m\nWarning: ${1}\n\e[0m"; }
error()   { echo -e "\e[1;31m\nError: ${1}\n\e[0m";  exit 1; }

du -h ~/.cache/thumbnails
sudo rm -rf ~/.cache/thumbnails/*
du -h ~/.cache/thumbnails

sudo du -h /var/lib/snapd
sudo rm -rf /var/lib/snapd/*
sudo du -h /var/lib/snapd

sudo du -sh /var/cache/apt/archives

# find /home -type f -exec du -h {} + | sort -hr | head -20


ps -aux | wc -l
sudo killall -e gsd-wacom 
sudo killall -e gsd-wwan
sudo killall -e gsd-smartcard
sudo killall -e gsd-print-notifications 
sudo killall -e gsd-screensaver-proxy
sudo killall -e gvfs-gphoto2-volume-monitor
sudo killall -e gnome-shell-calendar-server
sudo killall -e evolution-source-registry
sudo killall -e evolution-calendar-factory
sudo killall -e evolution-addressbook-factory
sudo killall -e evolution-alarm-notify
sudo killall -e wpa_supplicant
sudo killall -e cups-browsed
sudo killall -e update-notifier
sudo killall -e cupsd
sudo killall -e seahorse
ps -aux | wc -l

rm -r -v ~/.mozilla && rm -r -v ~/.cache/mozilla > dev/null

#sudo modprobe -r psmouse
#sudo modprobe -r uvcvideo
