#!/bin/bash
sudo mv dhcpcd.conf /etc/dhcpcd.conf
sudo service dhcpcd restart
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo mv dnsmasq.conf /etc/dnsmasq.conf
sudo systemctl start dnsmasq
sudo mv hostapd.conf /etc/hostapd/hostapd.conf
sudo sh -c 'echo DAEMON_CONF="/etc/hostapd/hostapd.conf" > /etc/default/hostapd'
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl start hostapd
jq '.WAP=true' /var/www/html/scripts/prefs.json > tmp.$$.json && mv tmp.$$.json /var/www/html/scripts/prefs.json
