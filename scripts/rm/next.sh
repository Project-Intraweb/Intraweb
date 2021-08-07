#!/bin/bash
echo -n "$(tput setaf 3)WARNING:$(tput sgr0) This script will remove ALL of your Nextcloud data
Continue?[y/n]: "
read next
if [[ $next = "y" ]];then
	sudo rm /var/www/html/nextcloud -R
	jq '.next=false' /var/www/html/scripts/prefs.json > tmp.$$.json && mv tmp.$$.json /var/www/html/scripts/prefs.json
else
	echo "Canceling..."
fi
