#!/bin/bash
echo "Please note that Intraweb files might be overwritten during the update process."
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

