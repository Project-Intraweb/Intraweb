#!/bin/bash
echo -n "Some things to remember:
- Your hostname MUST be raspberrypi
- Make sure ALL firewalls are disabled
- Make sure /var/www/html is empty
- Don't be an idiot
- Make sure you have sudo rights
Continue?[y/n]: "
read yesorno
if [ $yesorno = 'y' ]; then
    echo "Continuing..."
else
    echo "Canceling..."
    exit 0
fi
echo "Updating"
sudo apt update -y
sudo apt upgrade -y
echo "Installing dependencies"
sudo apt install -y snapd wget ca-certificates lsb-release python3 python3-setuptools python3-dev python3-pip dnsmasq hostapd perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python apt-transport-https golang curl
sudo snap install core
sudo systemctl stop dnsmasq
sudo systemctl stop hostapd

echo -n "Would you like to install Rocket.Chat?[y/n]: "
read rocket
if [ $rocket = 'y' ]; then
    echo "Installing Rocket Chat"
    sudo snap install rocketchat-server
fi

echo -n "Would you like to install Plex Media Server?[y/n]: "
read rocket
if [ $rocket = 'y' ]; then
    echo "Installing Plex Media Server"
    sudo snap install plexmediaserver
fi

echo -n "Would you like to install Wikipedia?[y/n]: "
read wiki
if [ $wiki = 'y' ]; then
    echo "Installing Wikipedia"
    pip3 install zimply
    sudo mv zimply.py /home/pi/wiki.py
    sudo mv zimply.service /etc/systemd/system/zimply.service
    sudo systemctl enable zimply.service
    sudo systemctl start zimply.service
fi

sudo mv *.html /var/www/html
sudo mv *.map /var/www/html
sudo mv *.css /var/www/html
sudo mv *.js /var/www/html
sudo mv *.jpeg /var/www/html
sudo mv *.png /var/www/html
sudo mv *.json /var/www/html
sudo mv phet /var/www/html

echo "Installing server"
sudo apt-get install apache2 -y
sudo apt-get install php7.3 php7.3-gd sqlite php7.3-sqlite3 php7.3-curl php7.3-zip php7.3-xml php7.3-mbstring -y
sudo service apache2 restart

echo -n "Would you like to install Nextcloud?[y/n]: "
read next
if [ $next = 'y' ]; then
    echo "Installing nextcloud"
    curl -Lo https://download.nextcloud.com/server/releases/latest.zip
    sudo unzip latest.zip
    sudo mkdir -p /var/www/html/nextcloud/data
    sudo chown -R www-data:www-data /var/www/html/nextcloud/
    sudo chmod 750 /var/www/html/nextcloud/data
fi

echo -n "Would you like to setup a Wireless Access point?[y/n]: "
read wifiap
if [ $wifiap = 'y' ]; then
    echo "Setting up Wireless Access point"
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
fi

echo -n "Would you like to install webmin (highly recomended)?[y/n]: "
read webmin
if [ $webmin = 'y' ]; then
    echo "Installing webmin"
    cd /home/pi
    wget http://prdownloads.sourceforge.net/webadmin/webmin_1.920_all.deb
    sudo dpkg --install webmin_1.920_all.deb
fi

echo -n "Would you like to install Gitlab?[y/n]: "
read gitlab
if [ $gitlab = 'y' ]; then
    cd /home/pi
    echo "Installing Gitlab"
    curl -Lo gitlab-ce_12.2.5-ce.0_armhf.deb https://packages.gitlab.com/gitlab/raspberry-pi2/packages/raspbian/stretch/gitlab-ce_12.2.5-ce.0_armhf.deb/download.deb
    sudo apt install ./gitlab-ce_12.2.5-ce.0_armhf.deb
    sudo sh -c 'echo external_url 'http://raspberrypi.local' > /etc/gitlab/gitlab.rb '
    sudo sh -c 'echo nginx['listen_port'] = 8081 > /etc/gitlab/gitlab.rb '
    sudo sh -c 'echo unicorn['worker_processes'] = 2 > /etc/gitlab/gitlab.rb '
    sudo sh -c 'echo sidekiq['concurrency'] = 9 > /etc/gitlab/gitlab.rb '
    sudo sh -c 'echo prometheus_monitoring['enable'] = false > /etc/gitlab/gitlab.rb '
    sudo gitlab-ctl reconfigure
fi
IFACE="$( ip r | grep "default via" | awk '{ print $5 }' | head -1 )"
IP="$( ip a show dev "$IFACE" | grep global | grep -oP '\d{1,3}(.\d{1,3}){3}' | head -1 )"

if [ $next = 'y' ]; then
    echo "Done.
    First: Visit http://$IP/nextcloud to configure your Nextcloud instance. Depending how large your zim file was, it may still take a while for it to fully index. Visit http://$IP to see all apps. Have fun! NOTE: SSL errors are normal. If you are using Chrome, to bypass the warning, wait for the page to fully load and just type to the page "thisisunsafe"."
else
    echo "Done.
    NOTE A: Depending how large your zim file was, it may still take a while for it to fully index.
    NOTE B: Visit http://$IP to see all apps.
    NOTE C: Have fun! 
    NOTE D: SSL errors are normal. If you are using Chrome, to bypass the warning, wait for the page to fully load and just type to the page "thisisunsafe"."
fi
exit 0
