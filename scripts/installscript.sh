#!/usr/bin/env bash
if ls /etc/apt/sources.list.d | grep webupd8
	then
	echo "Already have webupd8 ppas"
else
	sudo add-apt-repository -y ppa:nilarimogard/webupd8
	sudo add-apt-repository -y ppa:webupd8team/java
	sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
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
sudo apt-get install -y libusb-dev:i386
sudo apt-get install -y libreadline-dev:i386
sudo apt-get install -y gcc-multilib g++-multilib
sudo apt-get install -y sublime-text-installer terminator unity-tweak-tool gstreamer0.10-ffmpeg
sudo apt-get install -y gtk2-engines-murrine:i386 gtk2-engines-pixbuf:i386 sni-qt:i386 ubuntu-restricted-extras libc6:i386 libx11-6:i386 libasound2:i386 libatk1.0-0:i386 libcairo2:i386 libcups2:i386 libdbus-glib-1-2:i386 libgconf-2-4:i386 libgdk-pixbuf2.0-0:i386 libgtk-3-0:i386 libice6:i386 libncurses5:i386 libsm6:i386 liborbit2:i386 libudev1:i386 libusb-0.1-4:i386 libstdc++6:i386 libxt6:i386 libxtst6:i386 libgnomeui-0:i386 libusb-1.0-0-dev:i386 libcanberra-gtk-module:i386 libxss1
sudo apt-get install -y gcc-arm-none-eabi
sudo apt-get install -y linux-image-extra-virtual
sudo apt-get install -y mspdebug:i386
gem install colorize

if ls ~/.ssh/ |grep id_rsa.pub
	then
	echo "Already Have ssh key"
else
	cat /dev/zero | ssh-keygen -b 4096 -q -N ""
fi

mspdebug tilib > r.text

if grep r.text "MSP430.dll v3.3.1.4"; then
	echo "Already have mspdebug"
else
	sudo printf '%s\n    %s\n' 'Host buffet.cs.clemson.edu' 'StrictHostKeyChecking no' >> ~/.ssh/config
	wget https://github.com/kevinafreeman/MSP430-Guides/raw/master/mspdebug-fresh
	sudo rm -rf /usr/bin/mspdebug-fresh
	sudo cp mspdebug-fresh /usr/bin/
	sudo chmod +x /usr/bin/mspdebug-fresh
fi
rm r.text

if ls /opt |grep ti-mspgcc; then
	rm -rf /opt/ti-mspgcc
fi
TI_MSPGCC_URL=http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/3_04_05_01/exports/msp430-gcc-full-linux-installer-3.4.5.1.run
TI_MSPGCC_DIR=/opt/ti-mspgcc

echo "Downloading TI MSPGCC"
wget -qO installer $TI_MSPGCC_URL
echo "Installing TI MSPGCC"
chmod +x installer
./installer --mode unattended --prefix $TI_MSPGCC_DIR
# Copy headers and ldscripts to the correct location to prevent the need to explicitly include them
cp $TI_MSPGCC_DIR/{include/*.h,msp430-elf/include}
cp $TI_MSPGCC_DIR/{include/*.ld,msp430-elf/lib}
rm -rf installer

if cat /etc/profile |grep "ti-mspgcc"
	then
	echo "Already added ti-mspgcc"
else
	echo "export PATH=$TI_MSPGCC_DIR/bin:$PATH" >> /etc/profile
fi

$TI_MSPGCC_DIR/install_scripts/msp430uif_install.sh

sudo ln -sf /opt/ti-gcc/bin/libmsp430.so /usr/lib/
if grep "LD_LIBRARY_PATH" /home/vagrant/.zshrc; then
	echo "Have LD_LIBRARY_PATH already"
else
	sudo echo ``export LD_LIBRARY_PATH=/opt/ti-mspgcc/bin`` >> ~/.zshrc
fi

mkdir /home/kevin/Repos
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/kevinafreeman/dot-files.git ~/Repos/dot-files
rm -rf  ~/.zshrc
ln -s ~/Repos/dot-files/zshrc ~/.zshrc
cp ~/Repos/dot-files/kevin.zsh-theme ~/.oh-my-zsh/themes/

if ls ~/ |grep qm
	then
	rm -rf ~/qm
fi

rm -rf /home/vagrant/qm
wget http://sourceforge.net/projects/qpc/files/QM/3.3.0/qm_3.3.0-linux64/download
chmod +x download
./download --mode silent
rm download

if ls ~/ | grep Repos
	then
	cd ~/Repos
else
	mkdir ~/Repos
	cd ~/Repos
fi

if ls ~/Repos | grep project-amulet
	then
	echo "have project amulet"
else
	git clone git@bitbucket.org:kotzgroup/project-amulet.git
fi

if ls ~/Repos | grep lib-qpc
	then
	echo "have lib-qpc"
else
	git clone git@bitbucket.org:kotzgroup/lib-qpc.git
fi

echo "That's all folks"
