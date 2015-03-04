#!/bin/bash


echo "Installing packages"
    sudo add-apt-repository ppa:videolan/stable-daily
	sudo add-apt-repository ppa:deluge-team/ppa
	sudo apt-get update
	sudo apt-get install --yes mercurial 
	sudo apt-get install --yes zsh
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
echo "Done installing packages"



echo "Cloning bin directory"
	cd ${HOME}
	git clone https://github.com/Rastanislav/bin.git
	git clone https://github.com/clvv/fasd.git
	cd fasd
	sudo make install
echo "Done cloning bin directory"


echo "Installing ctags"
	cd ${HOME}/bin
	wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
	tar xzvf ctags-5.8.tar.gz
	rm ctags-5.8.tar.gz
	cd ctags-5.8
	./configure
	sudo make
	sudo make install 
echo "Done installing ctags"


echo "Installing Tmux"
	cd ${HOME}/bin
	wget http://downloads.sourceforge.net/tmux/tmux-1.9a.tar.gz
	tar xzvf tmux-1.9a.tar.gz
	rm tmux-1.9a.tar.gz
	cd tmux-1.9a
	./configure
	sudo make
	sudo make install 
echo "Done installing Tmux"


echo "Installing Vim"
	cd ${HOME}/bin
	hg clone https://vim.googlecode.com/hg/ vim
	hg pull
	hg update
	cd vim/src
	./configure \
   	 --enable-perlinterp \
   	 --enable-pythoninterp \
   	 --enable-rubyinterp \
     --enable-cscope \
   	 --enable-gui=auto \
   	 --enable-gtk2-check \
   	 --enable-gnome-check \
   	 --with-features=huge \
   	 --enable-multibyte \
   	 --with-x \
   	 --with-compiledby="Rastanislav" \
   	 --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu

	sudo make
	sudo make install 

	git clone https://github.com/Shougo/neobundle.vim.git  ${HOME}/.vim/bundle/neobundle.vim
	git clone https://github.com/saihoooooooo/glowshi-ft.vim.git ${HOME}/.vim/bundle/glowshi-ft.vim
#        map <unique>; <plug>(glowshi-ft-repeat)
#        unmap ;
# comment those lines in /home/rastanislav/dotfiles/vim/bundle/glowshi-ft.vim/plugin/glowshi_ft.vim
echo "Done installing Vim"

echo "Installing dotfiles"
	git clone https://github.com/Rastanislav/dotfiles2014.git dotfiles
	cd dotfiles
	./makesymlinks.sh
echo "Done installing dotfiles"


echo "Installing prezto dotfiles"
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
	chsh -s /bin/zsh

echo "Done installing prezto"


echo "Installing Skype"
	wget http://www.skype.com/go/getskype-linux-beta-ubuntu-64
	sudo dpkg -i getskype-*
	sudo apt-get -f --yes install
	sudo apt-get install sni-qt sni-qt:i386
echo "Done installing Skype"


echo "Organizing launch pad"
	gsettings set com.canonical.Unity.Launcher favorites "['application://firefox.desktop', 'application://skype.desktop', 'application://gnome-terminal.desktop', 'application://nautilus.desktop', 'application://deluge.desktop', 'application://vlc.desktop', 'application://libreoffice-writer.desktop', 'application://libreoffice-calc.desktop', 'application://libreoffice-impress.desktop', 'application://ubuntu-software-center.desktop', 'application://ubuntu-amazon-default.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"
echo "Done organizing launch pad"


echo "Installing FireFox"
	cd ${HOME}
	mkdir penta
	cd penta
	git clone https://gist.github.com/d7a57150aaccaae0e06d.git gist
	cp gist/penta_ff34.patch\  ${HOME}/penta 
	hg clone http://dactyl.googlecode.com/hg/ dactyl
	cd dactyl/
	patch -p1 < ../penta_ff34.patch\  
	make -C pentadactyl xpi
	firefox downloads/pentadactyl-1.2pre.xpi
echo "FireFox installed"

# shit that doesn't work after install:
#1)VIM: cant visually drag shit (S-UP/DOWN)
#2)VIM: comment out lines for ";" in glowshift plugin
