#!/usr/bin/env bash
chmod 777 /opt
chmod 777 /usr/local
chmod 777 /usr/lib/

add-apt-repository ppa:nilarimogard/webupd8
add-apt-repository ppa:webupd8team/java
add-apt-repository ppa:webupd8team/sublime-text-3
add-apt-repository ppa:mc3man/trusty-media

apt-get update

#Install Needed files to use and build amulet programs
apt-get install -y git build-essential subversion zsh oracle-java7-installer sublime-text-installer terminator unity-tweak-tool gstreamer0.10-ffmpeg gtk2-engines-murrine:i386 gtk2-engines-pixbuf:i386 sni-qt:i386 ubuntu-restricted-extras libdvdread4 libc6:i386 libx11-6:i386 libasound2:i386 libatk1.0-0:i386 libcairo2:i386 libcups2:i386 libdbus-glib-1-2:i386 libgconf-2-4:i386 libgdk-pixbuf2.0-0:i386 libgtk-3-0:i386 libice6:i386 libncurses5:i386 libsm6:i386 liborbit2:i386 libudev1:i386 libusb-0.1-4:i386 libstdc++6:i386 libxt6:i386 libxtst6:i386 libgnomeui-0:i386 libusb-1.0-0-dev:i386 libcanberra-gtk-module:i386 libxss1 libappindicator1 libindicator7 vlc


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
echo "export PATH=$TI_MSPGCC_DIR/bin:$PATH" >> /etc/profile
$TI_MSPGCC_DIR/install_scripts/msp430uif_install.sh
apt-get install -y mspdebug linux-image-extra-virtual
ln -s $TI_MSPGCC_DIR/bin/libmsp430.so /usr/lib/
/usr/share/doc/libdvdread4/install-css.sh

#install dev files
git clone anonymous@anonymous@buffet.cs.clemson.edu:kfreem2/devEnvFiles ~/Repos/devEnvFiles
dpkg -i ~/Repos/devEnvFiles/M0-files/jlink_4.92_i386.deb 
unzip ~/Repos/devEnvFiles/M0-files/nrf51822_sdk.zip -d /opt/nrf51822
#install qm modeling
chmod +x ~/Repos/devEnvFiles/qm/qm_3.2.0-linux64
~/Repos/devEnvFiles/qm/./qm_3.2.0-linux64 --mode silent
