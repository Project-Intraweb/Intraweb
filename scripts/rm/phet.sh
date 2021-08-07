#!/bin/bash
echo -n "$(tput setaf 3)WARNING:$(tput sgr0) This script will remove ALL of your PhET data
Continue?[y/n]: "
read phet
if [[ $phet = "y" ]];then
	sudo rm /var/www/html/phet -R
	jq '.phet=false' /var/www/html/scripts/prefs.json > tmp.$$.json && mv tmp.$$.json /var/www/html/scripts/prefs.json
else
	echo "Canceling..."
fi
