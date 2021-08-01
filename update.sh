#!/bin/bash
echo "Updating packages"
sudo apt-get update -y
sudo apt-get upgrade -y
cd ~/Intraweb
if git pull | grep -q 'Everything is up to date'; 
then
   echo "No new Intraweb updates!"
else 
  sudo bash upgrade.sh
fi

