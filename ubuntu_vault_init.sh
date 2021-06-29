#!/bin/bash

# wget -q https://raw.githubusercontent.com/loomanss/ubuntu-install/main/ubuntu_vault_init.sh | bash 
cd /tmp/
wget -q https://vault.bitwarden.com/download/?platform=linux&app=cli -O vault.zip
unzip vault.zip
sudo install bw /usr/local/bin/

echo " start usering bw with  export BW_SESSION=$(bw login <emailaddress> --raw) "
echo "bw get item http://url.com wil return full object. get the id"
echo "bw get password id wil return only password"

read MAILUSER
export BW_SESSION=$(bw login $MAILUSER --raw)
