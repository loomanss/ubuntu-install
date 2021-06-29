#!/bin/bash

# wget -qO - https://raw.githubusercontent.com/loomanss/ubuntu-install/main/ubuntu_vault_init.sh | bash 
cd /tmp/

wget -O vault.zip  "https://vault.bitwarden.com/download/?platform=linux&app=cli"
unzip vault.zip
sudo install bw /usr/local/bin/

echo " start usering bw with  export BW_SESSION=$(bw login <emailaddress> --raw) "
echo "bw get item http://url.com wil return full object. get the id"
echo "bw get password id wil return only password"

read bwusername
export BW_SESSION=$(bw login $bwusername --raw) 
echo "type "bw unlock"
echo "bw get password google"
bw unlock



bw list items | jq -c '.[] |select(.id|contains("53d2339c-70a1-4ed3-a077-aaf100a470bd")) | .notes' >> ~/.ssh/rsa_id
bw list items | jq -c '.[] |select(.id|contains("8e383309-94f8-4fbb-b381-ab4400caaf33")) | .notes' >> ~/.ssh/rsa_id.pub
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*
chmod 644 -f ~/.ssh/*.pub ~/.ssh/authorized_keys ~/.ssh/known_hosts
