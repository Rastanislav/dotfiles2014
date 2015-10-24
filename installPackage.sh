#!/bin/bash

echo "Installing packages"
	sudo add-apt-repository ppa:videolan/stable-daily
	sudo add-apt-repository ppa:deluge-team/ppa
	sudo apt-add-repository ppa:webupd8team/java
	sudo apt-get update
	sudo apt-get install --yes oracle-java8-installer
	sudo apt-get install --yes mercurial
	sudo apt-get install --yes python-pip
	sudo pip install subliminal
	sudo apt-get install --yes zsh
	sudo apt-get install --yes gimp
	sudo apt-get install --yes playitslowly
	sudo apt-get install --yes libevent-dev
	sudo apt-get install --yes python-dev
	sudo apt-get install --yes python3-dev
	sudo apt-get install --yes ruby
	sudo apt-get install --yes ruby-dev
	sudo apt-get install --yes libx11-dev
	sudo apt-get install --yes libxt-dev
	sudo apt-get install --yes libgtk2.0-dev
	sudo apt-get install --yes ncurses-dev
	sudo apt-get install --yes wireshark
	sudo apt-get install --yes solfege
	sudo apt-get install --yes tuxguitar-alsa
	sudo apt-get install --yes tuxguitar-jsa
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
	sudo apt-get install --yes npm
	sudo apt-get install --yes ack-grep
	sudo apt-get install --yes aircrack-ng
	sudo apt-get install --yes gtkpod
echo "Done installing packages"
