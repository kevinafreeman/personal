#!/usr/bin/env bash


TI_MSPGCC_URL=http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/2_01_01_00/exports/msp430-gcc-full-linux-installer-2.1.1.0.run
TI_MSPGCC_DIR=/opt/ti-mspgcc

echo "#############################################################
################### OFFICIAL UBUNTU REPOS ###################
#############################################################

###### Ubuntu Main Repos
deb http://www.gtlib.gatech.edu/pub/ubuntu/ trusty main restricted universe multiverse

###### Ubuntu Update Repos
deb http://www.gtlib.gatech.edu/pub/ubuntu/ trusty-security main restricted universe multiverse
deb http://www.gtlib.gatech.edu/pub/ubuntu/ trusty-updates main restricted universe multiverse
deb http://www.gtlib.gatech.edu/pub/ubuntu/ trusty-backports main restricted universe multiverse

###### Ubuntu Partner Repo
deb http://archive.canonical.com/ubuntu trusty partner

###### Ubuntu Extras Repo
deb http://extras.ubuntu.com/ubuntu trusty main

" > /etc/apt/sources.list

if cat /etc/apt/sources.list | grep -i webupd8
	then 
	echo "Already have sources"
else 
	echo "Need to add souces----adding now"
	sudo add-apt-repository ppa:nilarimogard/webupd8 
	sudo add-apt-repository ppa:webupd8team/java
	sudo add-apt-repository ppa:webupd8team/sublime-text-3
	sudo add-apt-repository ppa:mc3man/trusty-media 
	#Used to install mate desktop
	#sudo add-apt-repository ppa:danielrichter2007/grub-customizer
	#sudo apt-add-repository ppa:ubuntu-mate-dev/ppa
	#sudo apt-add-repository ppa:ubuntu-mate-dev/trusty-mate
fi

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
echo -e "Host buffet.cs.clemson.edu\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config

sudo apt-get update

#needed to install unity
#sudo apt-get install -y ubuntu-desktop 2> /dev/null
#needed to install mate
#sudo apt-get install -y --no-install-recommends ubuntu-mate-core ubuntu-mate-desktop
#Install Needed files to use and build amulet programs
sudo apt-get upgrade -y 
sudo apt-get install -y build-essential
sudo apt-get install -y linux-headers-3.13.0-37
sudo apt-get install -y git
sudo apt-get install -y zsh
sudo apt-get install -y libdvdread4
sudo apt-get install -y zip unzip
sudo apt-get install -y subversion sublime-text-installer terminator unity-tweak-tool gstreamer0.10-ffmpeg
sudo apt-get install -y gtk2-engines-murrine:i386 gtk2-engines-pixbuf:i386 sni-qt:i386 ubuntu-restricted-extras libc6:i386 libx11-6:i386 libasound2:i386 libatk1.0-0:i386 libcairo2:i386 libcups2:i386 libdbus-glib-1-2:i386 libgconf-2-4:i386 libgdk-pixbuf2.0-0:i386 libgtk-3-0:i386 libice6:i386 libncurses5:i386 libsm6:i386 liborbit2:i386 libudev1:i386 libusb-0.1-4:i386 libstdc++6:i386 libxt6:i386 libxtst6:i386 libgnomeui-0:i386 libusb-1.0-0-dev:i386 libcanberra-gtk-module:i386 
sudo apt-get install -y libxss1
sudo apt-get install -y gcc-arm-none-eabi


TI_MSPGCC_URL=http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/2_01_01_00/exports/msp430-gcc-full-linux-installer-2.1.1.0.run
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
sudo echo "export PATH=$TI_MSPGCC_DIR/bin:$PATH" >> /etc/profile
$TI_MSPGCC_DIR/install_scripts/msp430uif_install.sh
sudo apt-get install -y mspdebug linux-image-extra-virtual
ln -s $TI_MSPGCC_DIR/bin/libmsp430.so /usr/lib/
sudo /usr/share/doc/libdvdread4/install-css.sh


#install dev files
sudo git clone anonymous@buffet.cs.clemson.edu:kfreem2/devEnvFiles ~/Repos/devEnvFiles
dpkg -i ~/Repos/devEnvFiles/M0-files/jlink_4.92_x86_64.deb
ln -s ~/devEnvFiles/M0-files/nrf51822/ /opt/nrf51822
#install qm modeling
chmod +x ~/Repos/devEnvFiles/qm/qm_3.2.0-linux64
echo "Installing qm"
~/Repos/devEnvFiles/qm/./qm_3.2.0-linux64 --mode silent
echo "Installing CCS"
chmod +x ~/Repos/devEnvFiles/MSP430-files/ccs_setup_linux32.bin
~/Repos/devEnvFiles/MSP430-files/./ccs_setup_linux32.bin --mode unatended --prefix /opt/ccsv6


#Install Oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

git clone https://github.com/kevinafreeman/personal.git ~/Repos/github/kevin
#Install custom zshrc with aliases
ln -s ~/Repos/github/kevinzsh-files/zshrc ~/.zshrc
cp ~/Repos/github/kevin/zsh-files/kevin.zsh-theme ~/.oh-my-zsh/themes/
chsh -s /bin/zsh

#sudo usermod -a -G admin $USER

#Install Chrome beta
#wget https://dl.google.com/linux/direct/google-chrome-beta_current_amd64.deb
#sudo apt-get install -y libappindicator1 libindicator7
#sudo dpkg -i google-chrome*.deb
#Install updated libness - used with HTML5
#unzip ~/Repos/github/kevin/libness64bit.zip -d ~/Desktop/personal-master/
#sudo dpkg -i ~/Repos/github/kevin/libness64bit/libness64bit/libness*.deb
