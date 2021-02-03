#!/bin/bash
echo "you will lose default motd"
echo "if you dont see any color, search 'turn on color for commandline ssh' or anything like this"
initial_wd=`pwd`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

sudo chmod +x ./motd.sh
sudo chmod -x /etc/update-motd.d/*
if [ -f "/etc/motd" ]; then
    sudo rm /etc/motd
fi
sudo cp ./motd.sh /etc/profile.d
sudo sed 's/#\?\(PrintLastLog\s*\).*$/\1 no/' /etc/ssh/sshd_config > temp.txt 
sed -i  's/#\?\(PrintMotd\s*\).*$/\1 no/' temp.txt 
sudo mv -f temp.txt /etc/ssh/sshd_config
if [ -f temp.txt ]; then
    sudo rm temp.txt
fi
sudo systemctl restart sshd
cd $initial_wd