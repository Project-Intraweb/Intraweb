#!/bin/bash
sudo snap install plexmediaserver
jq '.plex=true' /var/www/html/scripts/prefs.json > tmp.$$.json && mv tmp.$$.json /var/www/html/scripts/prefs.json
