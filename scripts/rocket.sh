#!/bin/bash
sudo snap install rocketchat-server
jq '.rocket=true' /var/www/html/scripts/prefs.json > tmp.$$.json && mv tmp.$$.json /var/www/html/scripts/prefs.json
