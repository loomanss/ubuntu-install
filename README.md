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

# disable ip6 
# sudo sed -i -e 's/GRUB_CMDLINE_LINUX_DEFAULT="maybe-ubiquity"/GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 maybe-ubiquity"/' /etc/default/grub
sudo sed -i -e 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="ipv6.disable=1"/' /etc/default/grub
sudo update-grub


# set to belgian keyboard
sudo setxkbmap be
# cleanup tool
sudo apt-get install deborphan
# disable sudo password
echo "$USER     ALL=(ALL) NOPASSWD:ALL" > /tmp/$USER
sudo cp /tmp/$(echo $USER) /etc/sudoers.d/.

# Analyse active services
systemctl list-unit-files --state=enabled

```


## VirtualBox Vm's 
```bash
sudo apt-get install virtualbox-guest-additions-iso
sudo mkdir /media/iso
# depending on the version: 
sudo mount VBoxGuestAdditions_5.1.28.iso /media/iso


#remove snap if not needed
sudo snap remove snap-store
sudo snap remove gtk-common-themes
sudo snap remove gnome-3-34-1804
sudo snap remove core18
sudo snap remove core
sudo snap remove snapd
sudo apt purge snapd -y

# install visual studio code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders
sudo apt list --insalled | grep code

```
