#!/bin/bash
wget https://project-intraweb.github.io/phet.zip
mkdir phet
unzip phet.zip -d phet
mv ./phet /var/www/html/
jq '.phet=true' prefs.json > tmp.$$.json && mv tmp.$$.json prefs.json