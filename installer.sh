#!/bin/bash
echo -n "Some things to remember:
- All Apache and Nginx config will be overridden
- Make sure ALL firewalls are disabled
- Make sure /var/www/html is empty
- Don't be an idiot
- Make sure you have sudo rights
- It is recommended to close all other apps before continuing
Continue?[y/n]: "
read yesorno
if [ $yesorno = 'y' ]; then
    echo "Continuing..."
else
    echo "Canceling..."
    exit 0
fi
mv ./scripts /var/www/html
HOSTNAME="$( hostname )";
echo "Updating"
sudo apt update -y
sudo apt upgrade -y
echo "Installing dependencies"
sudo apt install -y snapd wget ca-certificates jq lsb-release python3 python3-setuptools python3-dev python3-pip dnsmasq hostapd perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python apt-transport-https golang curl
sudo snap install core
sudo systemctl stop dnsmasq
sudo systemctl stop hostapd

echo '{ "hostname": "'$HOSTNAME'", "rocket": false, "plex": false, "wiki": false, "next": false, "WAP": false, "webmin": false, "gitlab": false, "phet": false }' > ./scripts/prefs.json

echo -n "Would you like to install Rocket.Chat?[y/n]: "
read rocket
if [ $rocket = 'y' ]; then
    echo "Installing Rocket Chat"
    sudo bash /var/www/html/scripts/rocket.sh
fi

echo -n "Would you like to install Plex Media Server?[y/n]: "
read plex
if [ $plex = 'y' ]; then
    echo "Installing Plex Media Server"
    sudo bash /var/www/html/scripts/plex.sh
fi

echo -n "Would you like to install Wikipedia?[y/n]: "
read wiki
if [ $wiki = 'y' ]; then
    echo "Installing Wikipedia"
    sudo bash /var/www/html/scripts/wiki.sh
fi

echo -n "Would you like to install Phet?[y/n]: "
read phet
if [ $phet = 'y' ]; then
    echo "Installing Phet"
    sudo bash /var/www/html/scripts/phet.sh
fi
sudo mv index.php /var/www/html
sudo mv logo /var/www/html
sudo mv backdrop /var/www/html

echo "Installing server"
sudo apt-get install apache2 -y
sudo apt-get install php7.3 php7.3-gd sqlite php7.3-sqlite3 php7.3-curl php7.3-zip php7.3-xml php7.3-mbstring -y
sudo mv 000-default.conf /etc/apache2/sites-available/000-default.conf
sudo mv ports.conf /etc/apache2/ports.conf
sudo systemctl restart apache2
echo -n "Would you like to install Nextcloud?[y/n]: "
read next
if [ $next = 'y' ]; then
    echo "Installing Nextcloud"
    sudo bash /var/www/html/scripts/next.sh
fi

echo -n "Would you like to setup a Wireless Access Point?[y/n]: "
read wifiap
if [ $wifiap = 'y' ]; then
    echo "Setting up Wireless Access Point"
    sudo bash /var/www/html/scripts/WAP.sh
fi

echo -n "Would you like to install webmin (highly recomended)?[y/n]: "
read webmin
if [ $webmin = 'y' ]; then
    echo "Installing webmin"
    sudo bash /var/www/html/scripts/webmin.sh
fi
echo -n "Would you like to install Gitlab?[y/n]: "
read gitlab
if [ $gitlab = 'y' ]; then
    echo "Installing Gitlab"
    sudo bash /var/www/html/scripts/gitlab.sh
fi
IP="$( hostname -I | awk '{print $1}' )"

if [ $next = 'y' ]; then
    echo "DO: Visit http://$HOSTNAME.local/nextcloud to configure your Nextcloud instance."
fi
if [ $gitlab = 'y' ]; then
    echo "DO: Visit http://$HOSTNAME.local:6969 to configure your Gitlab instance."
fi
if [ $rocket = 'y' ]; then
    echo "DO: Visit http://$HOSTNAME.local:3000 to configure your Rocket.Chat instance."
fi
if [ $wiki = 'y' ]; then
    echo "NOTE A: Depending how large your zim file was, it may still take a while for it to fully index."
fi
    echo "NOTE: Visit http://$HOSTNAME.local to see all apps.
NOTE: Have fun! 
NOTE: SSL errors is nromal. If you are using Chrome, to bypass the warning, wait for the page to fully load and just type to the page "thisisunsafe"."
exit 0
