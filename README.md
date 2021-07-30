# Project Intraweb

A project that allows small communities, towns, clubs, and even companies to view content offline, or in an internal web environment.
## Nota Bene:
The project is still in active development and in an early stage. Hence the name Project Intraweb.

## Features:
* Hostspot setup enabled
* Ability to add custom sites
* Zim file reader for Wikipedia
* Rocketchat enabled
* Plex, Nextcloud, Gitlab, and more enabled

## Installation

Before you even start, download a .zim file with the content you want. I suggest heading over [here](http://download.kiwix.org/zim/). The file size depends on your SD card. You will also need the Pi to be connected to internet via ethernet, or any other wireless interface besides wlan0.

First, install the necessary dependencies.

```bash
sudo apt install -y git
```
Then clone the project and run the installer script.

```bash
cd Intraweb
sudo chmod +X installer.sh
sudo bash installer.sh
```
Once the script is done, configure your Nextcloud instances. All apps are in the apps section on the home page.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
## Sources
* [Nextcloud](https://nextcloud.com)
* [RocketChat](https://github.com/RocketChat/Rocket.Chat.RaspberryPi)
* [ZIMply](https://github.com/kimbauters/ZIMply)
* [Gitlab](https://about.gitlab.com/)
* [PHET](https://phet.colorado.edu/)
* [Webmin](http://www.webmin.com/)
* [Plex](https://www.plex.tv/)
## License
[MIT](https://choosealicense.com/licenses/mit/)
