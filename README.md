<<<<<<< HEAD
# ubuntu-install



# run the init script
```bash

# wget is installed default on ubuntu
wget -qO - https://raw.githubusercontent.com/loomanss/ubuntu-install/main/init.sh  | bash
# after installing this script ansible playbooks is preffered to install other software


curl -s https://raw.githubusercontent.com/loomanss/ubuntu-install/main/init.sh | bash /dev/stdin 
curl -s https://raw.githubusercontent.com/loomanss/ubuntu-install/main/init.sh | bash /dev/stdin arg1 arg2
wget -q http://mywebsite.com/myscript.txt -O 

```
=======
# ubuntu-install



# run the init script
```bash

# wget is installed default on ubuntu
wget -qO - https://raw.githubusercontent.com/loomanss/ubuntu-install/main/init.sh "<git email>" "<git user>"  | bash
# after installing this script ansible playbooks is preffered to install other software


curl -s https://raw.githubusercontent.com/loomanss/ubuntu-install/main/init.sh "<git email>" "<git user>" | bash /dev/stdin 
curl -s https://raw.githubusercontent.com/loomanss/ubuntu-install/main/init.sh | bash /dev/stdin arg1 arg2
wget -q http://mywebsite.com/myscript.txt -O 

```



# run the init script
get -qO - https://raw.githubusercontent.com/loomanss/ubuntu-install/main/rasp-init.sh | bash



# Other commands 
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

## Basic Commands

```bash
sudo apt update -y && sudo apt -y upgrade
sudo apt-get autoclean
sudo apt-get autoremove 
sudo apt install curl git -y
```

# disable ip6 
```bash
# sudo sed -i -e 's/GRUB_CMDLINE_LINUX_DEFAULT="maybe-ubiquity"/GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 maybe-ubiquity"/' /etc/default/grub
sudo sed -i -e 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="ipv6.disable=1"/' /etc/default/grub
sudo update-grub
```

# disable sudo password
```bash
echo "$USER     ALL=(ALL) NOPASSWD:ALL" > /tmp/$USER
sudo cp /tmp/$(echo $USER) /etc/sudoers.d/.
```

## automatic user login
```bash
cat > /tmp/set_autologon.sh << eof
#!/bin/bash
sudo sed -i -e 's/#  AutomaticLoginEnable = true/AutomaticLoginEnable = true/'  /etc/gdm3/custom.conf
sudo sed -i -e 's/#  AutomaticLogin = user1/AutomaticLogin = $USER/' /etc/gdm3/custom.conf
echo "done"
eof
chmod +x /tmp/set_autologon.sh
/tmp/set_autologon.sh
```


# set to belgian keyboard
```bash
sudo setxkbmap be
```

# cleanup tool
```bash
sudo apt-get install deborphan
```


# Analyse active services
```bash
systemctl list-unit-files --state=enabled
```

# slow boot analyzing
```
systemd-analyze blame
sudo systemctl disable vboxadd.service
# get boot time
systemd-analyze time
# all current processes
ps -aux 
```


## VirtualBox Vm's 
```bash
sudo apt-get install virtualbox-guest-additions-iso
sudo mkdir /media/iso
# depending on the version: 
sudo mount VBoxGuestAdditions_5.1.28.iso /media/iso
```

## services i dont need in a virtual-box ubuntu
```bash
systemctl list-unit-files --state=enabled | wc -l
sudo systemctl mask  bluetooth.service
sudo systemctl mask  cups.service
sudo systemctl mask  cups-browsed.service
sudo systemctl mask  NetworkManager-wait-online.service
sudo systemctl mask  pppd-dns.service
sudo systemctl mask  wpa_supplicant.service
sudo systemctl stop  snapd.seeded.service
sudo systemctl mask  snapd.seeded.service
sudo systemctl stop  openvpn.service 
sudo systemctl mask  openvpn.service 
sudo systemctl stop  rsync.service  
sudo systemctl mask  rsync.service  
sudo systemctl stop  ModemManager.service
sudo systemctl mask  ModemManager.service
sudo systemctl stop  avahi-daemon.service 
sudo systemctl mask  avahi-daemon.service 
sudo systemctl mask  apt-daily.timer
sudo systemctl stop  apt-daily.timer
sudo systemctl mask  apt-daily-upgrade.timer
sudo systemctl stop  apt-daily-upgrade.timer
systemctl list-unit-files --state=enabled | wc -l
```


## remove snap if not needed
```bash
sudo snap remove snap-store
sudo snap remove gtk-common-themes
sudo snap remove gnome-3-34-1804
sudo snap remove core18
sudo snap remove core
sudo snap remove snapd
sudo apt purge snapd -y
```


## Quick and Dirty process Cleanup
```bash
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
```
 ## experimental
 
```bash
sudo mv /usr/lib/evolution-data-server /usr/lib/evolution-data-server-disabled
sudo mv /usr/libexec/evolution-calendar-factory /usr/libexec/evolution-calendar-factory-disabled
sudo mv /usr/libexec/evolution-source-registry /usr/libexec/evolution-source-registry-disabled
sudo chmod -x /usr/libexec/evolution-calendar-factory
sudo chmod -x /usr/libexec/evolution-source-registry

# remove wireless tools.
sudo apt purge wpasupplicant wireless-tools -y
sudo apt purge modemmanager -y
sudo apt purge  speech-dispatcher-audio-plugins speech-dispatcher-espeak-ng speech-dispatcher -y
# So in short: remove leaves some config files behind where purge does not. And you can even use purge if later you want to delete those config files

```

# install visual studio code
```bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders
sudo apt list --insalled | grep code

```
>>>>>>> 3bb08324b97ea61e344e99719062278cb14c3276
