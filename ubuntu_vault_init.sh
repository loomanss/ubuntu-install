#!/bin/bash

# wget -qO - https://raw.githubusercontent.com/loomanss/ubuntu-install/main/ubuntu_vault_init.sh | bash 
cd /tmp/

wget -O vault.zip  "https://vault.bitwarden.com/download/?platform=linux&app=cli"
unzip vault.zip
sudo install bw /usr/local/bin/ 

echo ' start usering bw with  export BW_SESSION=$(bw login <emailaddress> --raw) '
echo "bw get item http://url.com wil return full object. get the id"
echo "bw get password id wil return only password"

read bwusername
export BW_SESSION=$(bw login $bwusername --raw) 
echo "type "bw unlock"
echo "bw get password google"

export BW_SESSION=$(bw unlock --raw)


bw list items | jq -c '.[] |select(.id|contains("53d2339c-70a1-4ed3-a077-aaf100a470bd")) | .notes' >> ~/.ssh/id_rsa.b64
 sed -ie 's/^"//'  ~/.ssh/id_rsa.b64
 sed -ie  's/"$//' ~/.ssh/id_rsa.b64
openssl base64  -A -d -in ~/.ssh/id_rsa.b64 -out ~/.ssh/id_rsa
cat  ~/.ssh/id_rsa


bw list items | jq -c '.[] |select(.id|contains("8e383309-94f8-4fbb-b381-ab4400caaf33")) | .notes' >> ~/.ssh/id_rsa.pub.b64
 sed -ie 's/^"//'  ~/.ssh/id_rsa.pub.b64
 sed -ie  's/"$//' ~/.ssh/id_rsa.pub.b64
openssl base64  -A -d -in ~/.ssh/id_rsa.pub.b64 -out ~/.ssh/id_rsa.pub
cat  ~/.ssh/id_rsa.pub

chmod 600 ~/.ssh/*
chmod 644 -f ~/.ssh/*.pub ~/.ssh/authorized_keys ~/.ssh/known_hosts
