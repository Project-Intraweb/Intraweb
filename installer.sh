#!/bin/bash

sudo apt update -y
sudo apt install -y snapd wget ca-certificates sudo lsb-release python3 python3-setuptools python3-dev python3-pip dnsmasq hostapd
sudo systemctl stop dnsmasq
sudo systemctl stop hostapd
sudo snap install rocketchat-server
pip3 install zimply
sudo mv zimply.py /home/pi/wiki.py
sudo mv zimply.service /etc/systemd/system/zimply.service
sudo systemctl enable zimply.service
sudo systemctl start zimply.service
sudo mv *.html /var/www/html
sudo mv *.map /var/www/html
sudo mv *.css /var/www/html
sudo mv *.js /var/www/html
sudo mv *.jpeg /var/www/html
sudo mv *.png /var/www/html
sudo mv *.json /var/www/html
sudo apt-get install apache2 -y
sudo apt-get install php7.3 php7.3-gd sqlite php7.3-sqlite3 php7.3-curl php7.3-zip php7.3-xml php7.3-mbstring
sudo service apache2 restart
curl https://download.nextcloud.com/server/releases/nextcloud-18.0.1.zip
sudo unzip nextcloud-18.0.1.zip
sudo mkdir -p /var/www/html/nextcloud/data
sudo chown -R www-data:www-data /var/www/html/nextcloud/
sudo chmod 750 /var/www/html/nextcloud/data
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
cd /home/pi
curl -Lo gitlab-ce_12.2.5-ce.0_armhf.deb https://packages.gitlab.com/gitlab/raspberry-pi2/packages/raspbian/stretch/gitlab-ce_12.2.5-ce.0_armhf.deb/download.deb
sudo apt install ./gitlab-ce_12.2.5-ce.0_armhf.deb
sudo sh -c 'echo external_url 'http://raspberrypi.local' > /etc/gitlab/gitlab.rb '
sudo sh -c 'echo nginx['listen_port'] = 8081 > /etc/gitlab/gitlab.rb '
sudo sh -c 'echo unicorn['worker_processes'] = 2 > /etc/gitlab/gitlab.rb '
sudo sh -c 'echo sidekiq['concurrency'] = 9 > /etc/gitlab/gitlab.rb '
sudo sh -c 'echo prometheus_monitoring['enable'] = false > /etc/gitlab/gitlab.rb '
sudo gitlab-ctl reconfigure
IFACE="$( ip r | grep "default via" | awk '{ print $5 }' | head -1 )"
IP="$( ip a show dev "$IFACE" | grep global | grep -oP '\d{1,3}(.\d{1,3}){3}' | head -1 )"
echo "Done.
First: Visit http://$IP/nextcloud to configure your Nextcloud instance. Depending how large your zim file was, it may still take a while for ti to fully index it. Visit http://$IP to see all apps. Have fun!"
exit 0