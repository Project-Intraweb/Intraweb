#!/bin/bash
wget https://download.nextcloud.com/server/releases/latest.zip
sudo unzip latest.zip
sudo mv nextcloud /var/www/html
rm latest.zip -f
sudo mkdir -p /var/www/html/nextcloud/data
sudo chown -R www-data:www-data /var/www/html/nextcloud/
sudo chmod 750 /var/www/html/nextcloud/data
jq '.next=true' prefs.json > tmp.$$.json && mv tmp.$$.json prefs.json