#!/bin/bash
# script to remove packages from 20.04 desktop

# wget -qO - https://raw.githubusercontent.com/loomanss/ubuntu-install/main/ubuntu_shrink.sh | bash

# automatic logon for Virtualbox-ubuntu

cat > /tmp/set_autologon.sh << eof
#!/bin/bash
sudo sed -i -e 's/#  AutomaticLoginEnable = true/AutomaticLoginEnable = true/'  /etc/gdm3/custom.conf
sudo sed -i -e 's/#  AutomaticLogin = user1/AutomaticLogin = $USER/' /etc/gdm3/custom.conf
echo "done"
eof
chmod +x /tmp/set_autologon.sh
/tmp/set_autologon.sh


# disable ip6 and smaller timeout for grub

sudo sed -i -e 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=1/' /etc/default/grub
sudo sed -i -e 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="ipv6.disable=1"/' /etc/default/grub
sudo update-grub


sudo apt update -y && sudo apt -y upgrade
sudo apt-get autoclean
sudo apt-get autoremove 
sudo apt install curl git jq -y


sudo apt autoremove snapd gnome-software-plugin-snap speech-dispatcher-audio-plugins speech-dispatcher-espeak-ng  speech-dispatcher \
whoopsie update-notifier update-notifier-common packagekit xserver-xorg-input-wacom libwacom-bin avahi-daemon gnome-bluetooth \
gnome-power-manager powermgmt-base gnome-themes-extra-data gnome-themes-extra pulseaudio pulseaudio-utils xul-ext-ubufox \
tracker tracker-extract tracker-miner-fs libmbim-proxy whoopsie bluez bluez-cups bluez-obexd  whoopsie-preferences \
gnome-online-accounts gvfs-backends apport apport-gtk apport-symptoms ubuntu-advantage-tools gnome-font-viewer \
gnome-calculator gnome-getting-started-docs  -y


# remove printer drivers
sudo apt autoremove printer-driver-m2300w printer-driver-splix printer-driver-postscript-hp printer-driver-pxljr printer-driver-min12xxw \ 
printer-driver-pnm2ppa printer-driver-foo2zjs printer-driver-brlaser printer-driver-c2esp printer-driver-ptouch  printer-driver-c2esp \
printer-driver-sag-gdi printer-driver-hpcups system-config-printer-common system-config-printer-udev \
cups-browsed cups-filters-core-drivers cups -y

# kernel cleanup

dpkg -l linux-* | awk '/^ii/{ print $2}' | grep -v -e `uname -r | cut -f1,2 -d"-"` | grep -e [0-9] | xargs sudo apt-get -y purge

# make it possible to disable uneeded startup apps
sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop


systemctl list-unit-files --state=enabled | wc -l
sudo systemctl mask  bluetooth.service
systemctl --reverse list-dependencies cups.service
systemctl disable cups.service cups.socket cups.path
sudo systemctl mask  cups-browsed.service
sudo systemctl mask  NetworkManager-wait-online.service
sudo systemctl stop pulseaudio-enable-autospawn
sudo systemctl mask pulseaudio-enable-autospawn
sudo systemctl stop alsa-util
sudo systemctl mask alsa-util
sudo systemctl mask  pppd-dns.service
sudo systemctl mask  wpa_supplicant.service
sudo systemctl stop  snapd.seeded.service
sudo systemctl mask  snapd.seeded.service
sudo systemctl stop  openvpn.service 
sudo systemctl mask  openvpn.service 
sudo systemctl stop  rsync.service  
sudo systemctl mask  rsync.service  
sudo systemctl stop  ModemManager.service
sudo systemctl mask  ModemManager.service
sudo systemctl stop  avahi-daemon.service 
sudo systemctl mask  avahi-daemon.service 
sudo systemctl mask  apt-daily.timer
sudo systemctl stop  apt-daily.timer
sudo systemctl mask  apt-daily-upgrade.timer
sudo systemctl stop  apt-daily-upgrade.timer
sudo systemctl stop apport
sudo systemctl mask apport
sudo systemctl mask ureadahead 
sudo systemctl mask plymouth 
sudo systemctl mask systemd.networkd.service
sudo systemctl mask packagekit.service
sudo systemctl stop whoopsie.service  
sudo systemctl mask whoopsie.service  

systemctl list-unit-files --state=enabled | wc -l


# journalctl optimalization

sudo journalctl --vacuum-size=300M --vacuum-time=2d --vacuum-files=5
#sudo rm /var/log/ -r


# disable animations and  background image to save mem
gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.desktop.background primary-color '#000455'
gsettings set org.gnome.desktop.interface enable-animations false

# other ui stuff
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.shell.overrides attach-modal-dialogs false  # modals don't "stick" to parent window
# gsettings set org.gnome.shell enable-hot-corners true
gsettings set org.gnome.settings-daemon.plugins.print-notifications active false

# disable some hardware-stuff not needed in virtualbox
gsettings set org.gnome.settings-daemon.plugins.gsdwacom active false
gsettings set org.gnome.settings-daemon.plugins.housekeeping active false
gsettings set org.gnome.settings-daemon.plugins.smartcard active false
gsettings set org.gnome.settings-daemon.plugins.sound active false
gsettings set org.gnome.desktop.interface show-battery-percentage false
gsettings set org.gnome.desktop.privacy disable-microphone true
gsettings set org.gnome.desktop.privacy disable-camera true
gsettings set org.gnome.login-screen enable-fingerprint-authentication false
gsettings set org.gnome.login-screen enable-smartcard-authentication false
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.privacy disable-sound-output true
gsettings set org.gnome.settings-daemon.plugins.keyboard active false

# gsettings set org.gtk.Settings.FileChooser show-hidden true
