#!/bin/bash
echo -n "$(tput setaf 3)WARNING:$(tput sgr0) This script will remove ALL of your WAP data
Continue?[y/n]: "
read plex
if [[ $plex = "y" ]];then
	sudo apt remove dhcpcd dnsmasq hostapd -y
	#jq '.rocket=false' /var/www/html/scripts/prefs.json > tmp.$$.json && mv tmp.$$.json /var/www/html/scripts/prefs.json
else
	echo "Canceling..."
fi
