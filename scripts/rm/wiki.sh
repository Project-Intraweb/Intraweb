#!/bin/bash
echo -n "$(tput setaf 3)WARNING:$(tput sgr0) This script will remove SOME of your Wikipedia data
Continue?[y/n]: "
read wiki
if [[ $wiki = "y" ]];then
	sudo pip3 uninstall zimply
	jq '.wiki=false' /var/www/html/scripts/prefs.json > tmp.$$.json && mv tmp.$$.json /var/www/html/scripts/prefs.json
else
	echo "Canceling..."
fi
