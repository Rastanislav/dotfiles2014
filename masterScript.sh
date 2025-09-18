#!/bin/bash

echo "Cloning bin directory"
	cd ${HOME}
	git clone https://github.com/Rastanislav/bin.git
	git clone https://github.com/clvv/fasd.git
	cd fasd
	sudo make install
echo "Done cloning bin directory"


echo "Installing dotfiles"
	git clone https://github.com/Rastanislav/dotfiles2014.git ${HOME}/dotfiles
	cd ${HOME}/dotfiles
	./makesymlinks.sh
echo "Done installing dotfiles"

echo "Installing thinkfan"
	cd ${HOME}/bin
	wget https://codeload.github.com/vmatare/thinkfan/zip/master
	extract thinkfan-master.zip
	cd thinkfan-master
	mkdir build && cd build
	cmake -D CMAKE_BUILD_TYPE:STRING=Debug ..
	make
	sudo make install
echo "Done installing thinkfan"

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

echo "Installing cusor"
	curl https://cursor.com/install -fsS | bash
	cursor-agent --version


echo "Done installing cursor"



	git clone https://github.com/Shougo/neobundle.vim.git  ${HOME}/.vim/bundle/neobundle.vim
	git clone https://github.com/saihoooooooo/glowshi-ft.vim.git ${HOME}/.vim/bundle/glowshi-ft.vim
#        map <unique>; <plug>(glowshi-ft-repeat)
#        unmap ;
# comment those lines in /home/rastanislav/dotfiles/vim/bundle/glowshi-ft.vim/plugin/glowshi_ft.vim


echo "Installing prezto dotfiles"
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
	chsh -s /bin/zsh

echo "Done installing prezto"


echo "Installing Go"
cd $HOME
mkdir -p Work/Go
curl -O https://dl.google.com/go/go1.9.4.linux-amd64.tar.gz
tar -xvf go1.9.4.linux-amd64.tar.gz
sudo mv go /usr/local/
rm go1.9.4.linux-amd64.tar.gz
echo "Done installing Skype"


echo "Organizing launch pad"
	gsettings set com.canonical.Unity.Launcher favorites "['application://firefox.desktop', 'application://skype.desktop', 'application://gnome-terminal.desktop', 'application://nautilus.desktop', 'application://deluge.desktop', 'application://vlc.desktop', 'application://libreoffice-writer.desktop', 'application://libreoffice-calc.desktop', 'application://libreoffice-impress.desktop', 'application://ubuntu-software-center.desktop', 'application://ubuntu-amazon-default.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"
echo "Done organizing launch pad"

cd ${HOME}/bin
git clone https://github.com/Diaoul/subliminal.git
cd subliminal
sudo python setup.py install



dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep 
#cd ${HOME}
#git clone https://github.com/ryanoasis/nerd-fonts.git
#sh ${HOME}/nerd-fonts/install.sh 

# copy dotfiles before installing this
cd ${HOME}
git clone https://github.com/junegunn/fzf.git
sudo bash ${HOME}/fzf/install

gvfs-mime --set x-scheme-handler/magnet deluge.desktop


sudo a2enmod rewrite
sudo service apache2 restart

# shit that doesn't work after install:
#1)VIM: cant visually drag shit (S-UP/DOWN)
#2)VIM: comment out lines for ";" in glowshift plugin


sudo groupadd docker
sudo gpasswd -a $USER docker
