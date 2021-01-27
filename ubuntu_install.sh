#/bin/bash
#   ubuntu_install.sh  Copyright (C) 2020 Arvind Mukund <armu30@gmail.com> 
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Installs all the essential packages.
echo "[*] Installing packages" 
sudo apt-get install -y adb bc bison build-essential ccache clang clang-format clang-tidy \
	clang-tools cmake curl docker.io fastboot firmware-amd-graphics firmware-iwlwifi \
	flex g++-multilib gcc-doc gcc-multilib gdb geany gimp git git-email gnupg gperf \
	hexedit imagemagick krita latexmk lib32ncurses5-dev lib32readline-dev lib32z1-dev \
	libavcodec-extra libc6-dbg libcurl4-gnutls-dev libglib2.0-dev libhidapi-* \
	libhidapi-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev \
	libusb-1.0-0-dev libxml2 libxml2-dev libxml2-utils ltrace lzop m4 nasm neovim \
	nmap openssl patchelf pkgconf pngcrush python-is-python3 python3-dev python3-pip \
	python3-setuptools qemu qemu-system qt5-qmake qtbase5-dev qtcreator rsync ruby \
	schedtool squashfs-tools strace texlive texlive-science texlive-xetex texstudio \
	valgrind vlc xsltproc zip zlib1g-dev libxcb-xtest0

# Make sure we have a local docker directory
echo "[*] Updating docker paths"
mkdir -p "$HOME/docker"
echo -ne "{\n\t\"data-root\":\"$HOME/docker\"\n}\n" | sudo tee /etc/docker/daemon.json

# Update adb rules
sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules https://raw.githubusercontent.com/snowdream/51-android/master/51-android.rules
sudo chmod a+r /etc/udev/rules.d/51-android.rules

# Installs libc one_gadget identifier.
echo "[*] Installing one_gadget"
sudo gem install one_gadget

# Installs custom gnome based accels shortcut
echo "[*] Installing terminal shortcuts"
./write_terminal_shortcut.sh

# Downloads and installs radare2 continous
./download_radare.sh

# Installs a few python packages
pip3 install --user -r ./requirements.txt
DATE=$(date)
echo -ne "\n# Generated by ubuntu_install.sh at $DATE\n" >> $HOME/.bashrc
echo -ne "export PATH=\"\$HOME/.local/bin:\$PATH\"\n\n" >> $HOME/.bashrc

## AYYYY
echo "[.] ALL DONE! Enjoy this now decent linux distribution"

