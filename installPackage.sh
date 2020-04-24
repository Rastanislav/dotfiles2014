#!/bin/bash

echo "Installing packages"
	sudo add-apt-repository ppa:masterminds/glide && sudo apt-get update
	sudo add-apt-repository ppa:videolan/stable-daily
	sudo add-apt-repository ppa:deluge-team/ppa
	sudo apt-add-repository ppa:webupd8team/java
	sudo apt-add-repository ppa:jtaylor/keepass -y
	sudo add-apt-repository ppa:gophers/archive
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
	echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
	
	sudo apt-get update
	sudo apt-get install --yes glide
	sudo apt install gnome-tweak-tool
	sudo apt install php-xdebug
	sudo apt-get install --yes cmake
	sudo apt-get install --yes composer
	sudo apt-get install --yes oracle-java8-installer
	sudo apt-get install --yes mercurial
	sudo apt-get install --yes yakuake
	sudo apt-get install --yes python3-setuptools
	sudo apt-get install --yes python-pip
	sudo apt-get install --yes python3-pip
	sudo apt-get install --yes yasm
	sudo apt-get install --yes apache2
	sudo apt-get install --yes mysql-server
	sudo apt-get install --yes php5 
	sudo apt-get install --yes libapache2-mod-php5
	sudo apt-get install --yes php5-mysql
	sudo apt-get install --yes phpmyadmin 
	sudo apt-get install --yes php-xml
	sudo apt-get install --yes php5.6-xml
	sudo apt-get install --yes php5.6-mcrypt
	sudo apt-get install --yes php5.6-curl
	sudo apt-get install --yes php5.6-gd
	sudo apt-get install --yes php5.6-soap
	sudo apt-get install --yes php7.0-mcrypt  
	sudo apt-get install --yes php7.0-curl 
	sudo apt-get install --yes php7.0-soap
	sudo apt-get install --yes apache2-utils
	sudo pip3 install mps-youtube 
	sudo pip install sqlitebiter
	sudo apt-get install --yes midori
	sudo apt-get install --yes zsh
	sudo apt-get install --yes libtool
	sudo apt-get install --yes automake
	sudo apt-get install --yes gimp
	sudo apt-get install --yes playitslowly
	sudo apt-get install --yes libevent-dev
	sudo apt-get install --yes pritunl
	sudo apt-get install --yes python-dev
	sudo apt-get install --yes python3-dev
	sudo apt-get install --yes ruby
	sudo apt-get install --yes lm-sensors
	sudo apt-get install --yes ruby-dev
	sudo apt-get install --yes libx11-dev
	sudo apt-get install --yes libxt-dev
	sudo apt-get install --yes libgtk2.0-dev
	sudo apt-get install --yes ncurses-dev
	sudo apt-get install --yes wireshark
	sudo apt-get install --yes solfege
	sudo apt-get install --yes tuxguitar-alsa
	sudo apt-get install --yes tuxguitar-jsa
	sudo apt-get install --yes libkrb5-dev
	sudo apt-get install --yes vlc
	sudo apt-get install --yes git
	sudo apt-get install --yes html2text
	sudo apt-get install --yes compizconfig-settings-manager
	sudo apt-get install --yes compiz-plugins
	sudo apt-get install --yes xdotool
	sudo apt-get install --yes flashplugin-installer
	sudo apt-get install --yes mplayer
	sudo apt-get install --yes deluge
	sudo apt-get install --yes nodejs
	sudo apt-get install --yes golang-1.9-go
	sudo apt-get install --yes ack-grep
	sudo apt-get install --yes aircrack-ng
	sudo apt-get install --yes gtkpod
	sudo apt-get install --yes acpi
	sudo apt-get install --yes pepperflashplugin-nonfree
	sudo apt-get install --yes playonlinux
	sudo apt-get install --yes chromium-browser
	sudo apt-get install --yes tmux
	sudo apt-get install --yes vim-gnome
	sudo apt-get install  --yes mysql-workbench
	sudo apt-get install  --yes keepass2
	sudo apt-get install  --yes filezilla
	sudo apt-get install  --yes docker
	sudo apt-get install  --yes docker-compose
	sudo apt-get install  --yes npm
	sudo apt-get install -y mongodb
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	sudo apt-get install --yes nodejs
	sudo apt-get install --yes yarn
	
echo "Done installing packages"
