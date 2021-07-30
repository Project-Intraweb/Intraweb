#!/bin/bash
cd ~/Intraweb
sudo apt update -y
sudo apt install -y snapd wget ca-certificates lsb-release python3 python3-setuptools python3-dev python3-pip dnsmasq hostapd perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python apt-transport-https golang
sudo systemctl stop dnsmasq
sudo systemctl stop hostapd
sudo snap install rocketchat-server
pip3 install zimply
sudo mv zimply.py /home/pi/wiki.py
sudo mv zimply.service /etc/systemd/system/zimply.service
sudo systemctl enable zimply.service
sudo systemctl start zimply.service
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
sudo apt-get update
sudo apt-get install plexmediaserver
sudo mv *.html /var/www/html
sudo mv *.map /var/www/html
sudo mv *.css /var/www/html
sudo mv *.js /var/www/html
sudo mv *.jpeg /var/www/html
sudo mv *.png /var/www/html
sudo mv *.json /var/www/html
sudo mv phet /var/www/html
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
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.920_all.deb
sudo dpkg --install webmin_1.920_all.deb
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
First: Visit http://$IP/nextcloud to configure your Nextcloud instance. Depending how large your zim file was, it may still take a while for it to fully index. Visit http://$IP to see all apps. Have fun! NOTE: Facing SSL errors is nromal. IF you are using Chrome, to bypass the warning, wait for the page to fully load and just type to the page "thisisunsafe"."
exit 0
