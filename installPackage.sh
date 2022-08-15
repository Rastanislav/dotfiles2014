#!/bin/bash

echo "Installing packages"
sudo tee /etc/apt/sources.list.d/pritunl.list << EOF
deb https://repo.pritunl.com/stable/apt focal main
EOF

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo apt-get update
sudo apt-get install pritunl-client-electron
	sudo add-apt-repository ppa:masterminds/glide && sudo apt-get update
	sudo add-apt-repository ppa:videolan/stable-daily
	sudo add-apt-repository ppa:deluge-team/ppa
	sudo apt-add-repository ppa:webupd8team/java
	sudo apt-add-repository ppa:jtaylor/keepass -y
	sudo add-apt-repository ppa:gophers/archive
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
	
	sudo apt-get update
	sudo apt-get install --yes glide
	sudo apt-get install --yes gnome-tweak-tool
	sudo apt-get install --yes php-xdebug
	sudo apt-get install --yes gnupg
	wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
	echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
	sudo apt-get update
	sudo apt-get install -y mongodb-org
	sudo apt-get install --yes cmake
	sudo apt-get install --yes libyaml-cpp-dev 
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
	sudo apt-get install --yes sensors-applet 
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
	sudo apt-get install --yes golang
	sudo apt-get install --yes ack-grep
	sudo apt-get install --yes aircrack-ng
	sudo apt-get install --yes gtkpod
	sudo apt-get install --yes acpi
	sudo apt-get install --yes pepperflashplugin-nonfree
	sudo apt-get install --yes playonlinux
	sudo apt-get install --yes tmux
	sudo apt-get install --yes vim-gtk
	sudo apt-get install  --yes mysql-workbench
	sudo apt-get install  --yes keepass2
	sudo apt-get install  --yes filezilla
	sudo apt-get install  --yes docker
	sudo apt-get install  --yes docker-compose
	sudo apt-get install  --yes npm
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	sudo apt-get install --yes nodejs
	sudo apt-get install --yes yarn
	sudo apt-get install --yes telegram-desktop
	sudo apt-get install --yes pavucontrol
	sudo apt-get install --yes postgresql
	sudo apt-get install --yes postgresql-client
	wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -
	echo "deb https://packages.erlang-solutions.com/ubuntu focal contrib" | sudo tee /etc/apt/sources.list.d/rabbitmq.list
	sudo apt install --yes apt-transport-https
	sudo apt install --yes erlang
	wget -O- https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc | sudo apt-key add -
	wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
	echo "deb https://dl.bintray.com/rabbitmq-erlang/debian focal erlang-22.x" | sudo tee /etc/apt/sources.list.d/rabbitmq.list
	sudo apt install --yes rabbitmq-server
	sudo systemctl start mongod
	sudo tee /etc/apt/sources.list.d/pritunl.list << EOF
deb https://repo.pritunl.com/stable/apt jammy main
EOF

sudo apt --assume-yes install gnupg
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A
gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A | sudo tee /etc/apt/trusted.gpg.d/pritunl.asc
sudo apt update
echo "Done installing packages"
