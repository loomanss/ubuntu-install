#!/bin/bash

# wget -qO - https://raw.githubusercontent.com/loomanss/ubuntu-install/main/ubuntu_vault_init.sh | bash 

# wget https://raw.githubusercontent.com/loomanss/ubuntu-install/main/ubuntu_vault_init.sh  && chmod +x ubuntu_vault_init.sh && ./ubuntu_vault_init.sh 

if [[ -f "/tmp/vault.zip" ]]; then
  echo "removing old download version..."
  rm /tmp/vault.zip
  rm /tmp/bw
fi

if [[ -f "/usr/local/bin/bw" ]]; then
  echo "removing old installed version..."
  sudo rm /usr/local/bin/bw
fi

 sudo apt install git curl jq


if [[ -z "${USER_EMAIL}" ]]; then
  echo "your emailaddress"
  read USER_EMAIL
else
  echo "USER_EMAIL found! ..."
fi

if [[ -z "${USER_NAME}" ]]; then
echo "your name"
read USER_NAME
else
  echo "USER_NAME found! ..."
fi



git config --global user.email "$USER_EMAIL"
git config --global user.name "$USER_NAME"


echo "Downloading ..."
wget -O /tmp/vault.zip  "https://vault.bitwarden.com/download/?platform=linux&app=cli"
echo "Unpack ..."
unzip /tmp/vault.zip
echo "Install ..."
sudo install bw /usr/local/bin/ 

echo ' start usering bw with  export BW_SESSION=$(bw login <emailaddress> --raw) '
echo "bw get item http://url.com wil return full object. get the id"
echo "bw get password id wil return only password"


echo "Configure ..."
export BW_SESSION=$(bw login --raw) 


echo "installing ssh keys ..."
bw list items | jq -c '.[] |select(.id|contains("53d2339c-70a1-4ed3-a077-aaf100a470bd")) | .notes' >> ~/.ssh/id_rsa.b64
sed -ie 's/^"//'  ~/.ssh/id_rsa.b64
sed -ie 's/"$//' ~/.ssh/id_rsa.b64
openssl base64  -A -d -in ~/.ssh/id_rsa.b64 -out ~/.ssh/id_rsa




cat  ~/.ssh/id_rsa


bw list items | jq -c '.[] |select(.id|contains("8e383309-94f8-4fbb-b381-ab4400caaf33")) | .notes' >> ~/.ssh/id_rsa.pub.b64
sed -ie 's/^"//'  ~/.ssh/id_rsa.pub.b64
sed -ie 's/"$//' ~/.ssh/id_rsa.pub.b64
openssl base64  -A -d -in ~/.ssh/id_rsa.pub.b64 -out ~/.ssh/id_rsa.pub
cat  ~/.ssh/id_rsa.pub

chmod 600 ~/.ssh/*
chmod 644 -f ~/.ssh/*.pub ~/.ssh/authorized_keys ~/.ssh/known_hosts


 >> ~/.bashrc
#alias bwun='export BW_SESSION=$(bw unlock --raw)' >> ~/.bashrc
alias bwout='bw logout' >> ~/.bashrc
#source ~/.bashrc

printf "%s\n" "alias bwin='export BW_SESSION=$(bw login --raw)'" >> ~/.bashrc
printf "%s\n" "alias bwout='bw logout'" >> ~/.bashrc
