#!/bin/bash
sudo -i
sudo apt update -y
sudo apt install -y snapd wget ca-certificates sudo lsb-release python3 python3-setuptools python3-dev python3-pip
sudo snap install rocketchat-server
pip3 install zimply
sudo mv zimply.py /home/pi/zimply.py
sudo mv zimply.service /etc/systemd/system/zimply.service
sudo systemctl enable zimply.service
sudo systemctl start zimply.service
mktemp -d /tmp/nextcloudpi && cd /tmp/nextcloudpi
wget -qO- --content-disposition https://github.com/nextcloud/nextcloudpi/archive/master/latest.tar.gz
cd nextcloudpi-master
source etc/library.sh
check_distro etc/ncp.cfg || {
  echo "ERROR: distro not supported:";
  cat /etc/issue
  exit 1;
}
mkdir -p /usr/local/etc/ncp-config.d/
cp etc/ncp-config.d/nc-nextcloud.cfg /usr/local/etc/ncp-config.d/
cp etc/library.sh /usr/local/etc/
cp etc/ncp.cfg /usr/local/etc/
install_app    lamp.sh
install_app    bin/ncp/CONFIG/nc-nextcloud.sh
run_app_unsafe bin/ncp/CONFIG/nc-nextcloud.sh
systemctl restart mysqld
install_app    ncp.sh
run_app_unsafe bin/ncp/CONFIG/nc-init.sh
bash /usr/local/bin/ncp-provisioning.sh
sudo mv /home/pi/Intraweb/ports.conf /etc/apache2/ports.conf
sudo mv /home/pi/Intraweb/000-default.conf /etc/apache2/sites-enabled/000-default.conf
sudo /etc/init.d/apache2 reload
popd
IFACE="$( ip r | grep "default via" | awk '{ print $5 }' | head -1 )"
IP="$( ip a show dev "$IFACE" | grep global | grep -oP '\d{1,3}(.\d{1,3}){3}' | head -1 )"
echo "Done.
First: Visit http://$IP:880 to configure your nextcloudpi instance. Depending how large your zim file was, it may still take a while for ti to fully index it. Visit http://$IP to see all apps. Have fun!"
exit 0
