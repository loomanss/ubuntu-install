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


## Basic Commands
```bash
sudo apt update -y && sudo apt -y upgrade
# set to belgian keyboard
setxkbmap be
# cleanup tool
sudo apt-get install deborphan


## VirtualBox Vm's 
```bash
sudo apt-get install virtualbox-guest-additions-iso
sudo mkdir /media/iso
# depending on the version: 
sudo mount VBoxGuestAdditions_5.1.28.iso /media/iso
```
