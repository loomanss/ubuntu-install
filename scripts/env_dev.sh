sudo wget -qO - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -
sudo apt-get update
sudo apt remove virtualbox-dkms virtualbox-ext-pack virtualbox-qt virtualbox-guest-utils virtualbox-guest-dkms-hwe virtualbox-guest-additions-iso virtualbox
sudo apt autoremove
sudo apt-get purge virtualbox*
sudo apt install virtualbox -y
sudo cd /tmp/
sudo wget https://download.virtualbox.org/virtualbox/6.1.10/Oracle_VM_VirtualBox_Extension_Pack-6.1.10.vbox-extpack
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.1.10.vbox-extpack

sudo apt install dkms build-essential linux-headers-`uname -r`  -y
sudo dpkg-reconfigure virtualbox-dkms 
sudo dpkg-reconfigure virtualbox
sudo dpkg-reconfigure  virtualbox-ext-pack
sudo apt-get install linux-headers-generic -y


sudo apt-get install dkms build-essential linux-headers-`uname -r` -y







sudo apt-get remove virtualbox virtualbox-4.* virtualbox-5.0


