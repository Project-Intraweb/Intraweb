#!/bin/bash
HOSTNAME="$( hostname )"
curl -Lo gitlab-ce_12.2.5-ce.0_armhf.deb https://packages.gitlab.com/gitlab/raspberry-pi2/packages/raspbian/stretch/gitlab-ce_12.2.5-ce.0_armhf.deb/download.deb
sudo apt install ./gitlab-ce_12.2.5-ce.0_armhf.deb
sudo sh -c 'echo external_url 'http://$HOSTNAME.local' > /etc/gitlab/gitlab.rb '
sudo sh -c 'echo nginx['listen_port'] = 6969 > /etc/gitlab/gitlab.rb '
sudo sh -c 'echo unicorn['worker_processes'] = 2 > /etc/gitlab/gitlab.rb '
sudo sed -i '88d' /opt/gitlab/embedded/cookbooks/gitlab/attributes/default.rb
sudo sed -i "88s/^/default['gitlab']['gitlab-rails']['gitlab-port'] = 6969\n/" /opt/gitlab/embedded/cookbooks/gitlab/attributes/default.rb
sudo gitlab-ctl reconfigure
jq '.gitlab=true' /var/www/html/scripts/prefs.json > tmp.$$.json && mv tmp.$$.json /var/www/html/scripts/prefs.json
