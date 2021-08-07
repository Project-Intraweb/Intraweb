#!/bin/bash
echo -n "$(tput setaf 3)WARNING:$(tput sgr0) This script will remove ALL of your PLEX data
Continue?[y/n]: "
read plex
if [[ $plex = "y" ]];then
	sudo snap remove plexmediaserver
	jq '.plex=false' /var/www/html/scripts/prefs.json > tmp.$$.json && mv tmp.$$.json /var/www/html/scripts/prefs.json
else
	echo "Canceling..."
fi
