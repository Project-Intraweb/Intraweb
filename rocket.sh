#!/bin/bash
sudo snap install rocketchat-server
jq '.rocket=true' prefs.json > tmp.$$.json && mv tmp.$$.json prefs.json