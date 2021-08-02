#!/bin/bash
sudo snap install plexmediaserver
jq '.plex=true' prefs.json > tmp.$$.json && mv tmp.$$.json prefs.json