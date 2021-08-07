#!/bin/bash
echo -n "$(tput setaf 3)WARNING:$(tput sgr0) This script will remove ALL of your Rocket.Chat data
Continue?[y/n]: "
read rocket
if [[ $rocket = "y" ]];then
	sudo snap remove rocketchat-server
	jq '.rocket=false' /var/www/html/scripts/prefs.json > tmp.$$.json && mv tmp.$$.json /var/www/html/scripts/prefs.json
else
	echo "Canceling..."
fi
