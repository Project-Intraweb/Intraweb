#!/bin/bash
sudo bash /etc/webmin/uninstall.sh
jq '.webmin=false' /var/www/html/scripts/prefs.json > tmp.$$.json && mv tmp.$$.json /var/www/html/scripts/prefs.json
