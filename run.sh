#!/bin/bash
DIR="$(dirname "${BASH_SOURCE[0]}")"  
sudo cd "$DIR"
sudo chmod +x ./motd.sh
if [ -f "/etc/motd" ]; then
    sudo rm /etc/motd
fi
sudo mv ./motd.sh /etc/profile.d
sudo sed 's/#\?\(PrintLastLog\s*\).*$/\1 no/' /etc/ssh/sshd_config > temp.txt 
sed -i  's/#\?\(PrintMotd\s*\).*$/\1 no/' temp.txt 
sudo rm temp.txt
sudo mv -f temp.txt /etc/ssh/sshd_config

sudo systemctl restart sshd