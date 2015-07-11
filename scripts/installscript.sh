#!/usr/bin/env bash
if ls /etc/apt/sources.list.d | grep webupd8
	then
	echo "Already have sources"
else
	echo "Need to add souces----adding now"
	sudo add-apt-repository -y ppa:nilarimogard/webupd8
	sudo add-apt-repository -y ppa:webupd8team/java
	sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
	sudo add-apt-repository -y ppa:mc3man/trusty-media
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

cat /dev/zero | ssh-keygen -b 4096 -q -N ""

#http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/3_02_02_00/exports/msp430-gcc-full-linux-installer-3.3.4.0.run
TI_MSPGCC_URL=http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/3_02_02_00/exports/msp430-gcc-full-linux-installer-3.2.2.0.run
TI_MSPGCC_DIR=/opt/ti-mspgcc

echo "Downloading TI MSPGCC"
wget -qO installer $TI_MSPGCC_URL
echo "Installing TI MSPGCC"
chmod +x installer
./installer --mode unattended --prefix $TI_MSPGCC_DIR
rm installer
# Copy headers and ldscripts to the correct location to prevent the need to explicitly include them
cp $TI_MSPGCC_DIR/{include/*.h,msp430-elf/include}
cp $TI_MSPGCC_DIR/{include/*.ld,msp430-elf/lib}

echo "export PATH=$TI_MSPGCC_DIR/bin:$PATH" >> /etc/profile
$TI_MSPGCC_DIR/install_scripts/msp430uif_install.sh

ln -s $TI_MSPGCC_DIR/bin/libmsp430.so /usr/lib/

printf '%s\n    %s\n' 'Host buffet.cs.clemson.edu' 'StrictHostKeyChecking no' >> ~/.ssh/config
git clone anonymous@buffet.cs.clemson.edu:jhester/mspdebug-fresh
cd mspdebug-fresh
make
sudo mv /usr/bin/mspdebug /usr/bin/mspdebug_old
sudo cp mspdebug /usr/bin/mspdebug
cd ..
rm -r mspdebug-fresh

mkdir /home/kevin/Repos
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/kevinafreeman/dot-files.git ~/Repos/dot-files
ln -s ~/Repos/dot-files/zshrc ~/.zshrc
cp ~/Repos/dot-files/kevin.zsh-theme ~/.oh-my-zsh/themes/

wget http://tcpdiag.dl.sourceforge.net/project/qpc/QM/3.3.0/qm_3.3.0-linux64
chmod +x qm_3.3.0-linux64
./qm_3.3.0-linux64 --mode silent
rm qm_3.3.0-linux64
