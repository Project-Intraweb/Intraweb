#!/bin/bash
pip3 install zimply
sudo mv zimply.py /home/pi/wiki.py
sudo mv zimply.service /etc/systemd/system/zimply.service
sudo systemctl enable zimply.service
sudo systemctl start zimply.service
jq '.wiki=true' prefs.json > tmp.$$.json && mv tmp.$$.json prefs.json