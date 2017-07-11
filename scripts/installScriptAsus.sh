#!/usr/bin/env bash
if ls /etc/apt/sources.list.d | grep webupd8
	then
	echo "Already have webupd8 ppas"
else
	sudo add-apt-repository -y ppa:nilarimogard/webupd8
	sudo add-apt-repository -y ppa:webupd8team/java
fi

if ls /etc/apt/sources.list.d | grep danielrichter2007
	then
	echo "Already have Grub customizer ppa"
else
	sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
fi

sudo chown $(logname):$(logname) /opt
sudo apt-get update

sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install -y build-essential
sudo apt-get install -y linux-headers-$(uname -r)
sudo apt-get install -y git rake mercurial zsh ssh subversion
sudo apt-get install -y zsh
sudo apt-get install -y libdvdread4
sudo apt-get install -y zip unzip
sudo apt-get install -y gcc-multilib g++-multilib
sudo apt-get install -y terminator unity-tweak-tool vim-gtk3 texlive-full texlive-bibtex-extra texlive-bibtex-extra texstudio
sudo apt-get install -y vlc gimp inkscape kicad ghex gparted fail2ban 
gem install colorize

if ls ~/.ssh/ |grep id_rsa.pub
	then
	echo "Already Have ssh key"
else
	cat /dev/zero | ssh-keygen -b 4096 -q -N ""
fi

mkdir ~/Repos
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/kevinafreeman/dot-files.git ~/Repos/dot-files
rm -rf  ~/.zshrc
ln -s ~/Repos/dot-files/zshrc ~/.zshrc
cp ~/Repos/dot-files/kevin.zsh-theme ~/.oh-my-zsh/themes/


echo "Get to Frickin' Work !!!"

