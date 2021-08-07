#!/bin/bash
echo -n "$(tput setaf 3)WARNING:$(tput sgr0) This script will remove ALL of your gitlab data
Continue?[y/n]: "
read gitlab
if [[ $gitlab = "y" ]];then
	sudo gitlab-ctl uninstall
	sudo gitlab-ctl cleanse
	sudo gitlab-ctl remove-accounts
	sudo dpkg -P gitlab-ce
	sudo rm /opt/gitlab -R
	sudo rm /var/opt/gitlab -R
	sudo rm /etc/gitlab -R
	sudo rm /var/log/gitlab -R
	jq '.gitlab=false' /var/www/html/scripts/prefs.json > tmp.$$.json && mv tmp.$$.json /var/www/html/scripts/prefs.json
else
	echo "Canceling..."
fi
