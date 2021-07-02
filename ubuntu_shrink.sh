#!/bin/bash
# script to remove packages from 20.04 desktop

message() { echo -e "\e[1;32m\n${1}\n\e[0m"; }
warning() { echo -e "\e[1;33m\nWarning: ${1}\n\e[0m"; }
error()   { echo -e "\e[1;31m\nError: ${1}\n\e[0m";  exit 1; }



# wget -qO - https://raw.githubusercontent.com/loomanss/ubuntu-install/main/ubuntu_shrink.sh | bash



# sudo sed -i -e 's/GRUB_CMDLINE_LINUX_DEFAULT="maybe-ubiquity"/GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 maybe-ubiquity"/' /etc/default/grub
sudo sed -i -e 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="ipv6.disable=1"/' /etc/default/grub
sudo update-grub

message "Disable sudo password..."

echo "$USER     ALL=(ALL) NOPASSWD:ALL" > /tmp/$USER
sudo cp /tmp/$(echo $USER) /etc/sudoers.d/.

message "setting autologon..."
# automatic logon for Virtualbox-ubuntu

cat > /tmp/set_autologon.sh << eof
#!/bin/bash
sudo sed -i -e 's/#  AutomaticLoginEnable = true/AutomaticLoginEnable = true/'  /etc/gdm3/custom.conf
sudo sed -i -e 's/#  AutomaticLogin = user1/AutomaticLogin = $USER/' /etc/gdm3/custom.conf
echo "done"
eof
chmod +x /tmp/set_autologon.sh
/tmp/set_autologon.sh

# disable sudo password 
message "disable credential-check when sudoing ..."
echo "$USER     ALL=(ALL) NOPASSWD:ALL" > /tmp/$USER
sudo cp /tmp/$(echo $USER) /etc/sudoers.d/.


# disable ip6 and smaller timeout for grub
message "disable ip and bring down grub_timeout to s..."
sudo sed -i -e 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=1/' /etc/default/grub
sudo sed -i -e 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="ipv6.disable=1"/' /etc/default/grub
sudo update-grub

message "apt update and install curl git jq..."
sudo apt update -y && sudo apt -y upgrade
sudo apt install curl git jq autoremove autoclean -y


message "remove gnome stuff...."
 sudo apt autoremove snapd gnome-software-plugin-snap speech-dispatcher-audio-plugins speech-dispatcher-espeak-ng  speech-dispatcher -y
 sudo apt autoremove update-notifier update-notifier-common packagekit avahi-daemon  -y
 sudo apt autoremove gnome-power-manager powermgmt-base  xul-ext-ubufox -y

sudo apt autoremove apport apport-gtk apport-symptoms -y
 sudo apt autoremove gnome-online-accounts gvfs-backends   -y
 sudo apt autoremove gnome-calculator gnome-getting-started-docs  -y
 sudo apt autoremove xserver-xorg-input-wacom libwacom-bin
 sudo apt autoremove ubuntu-advantage-tools gnome-themes-extra-data gnome-themes-extra -y
 
message "remove tracking stuff...."
sudo apt autoremove tracker tracker-extract tracker-miner-fs libmbim-proxy 
message "remove sound stuff...."
sudo apt autoremove alsa-base gstreamer1.0-pulseaudio pulseaudio pulseaudio-utils yaru-theme-sound  alsa-topology-conf alsa-ucm-conf  alsa-utils -y
message "remove bluetooth stuff...."
sudo apt autoremove libbluetooth3 bluez bluez-cups bluez-obexd gnome-bluetooth -y
sudo apt autoremove chromium-codecs-ffmpeg-extra
sudo apt autoremove whoopsie whoopsie-preferences -y 
message "remove Network stuff...."
sudo apt-get autoremove  wireless-tools wireless-regdb pcmciautils seahorse -y 
sudo apt-get autoremove network-manager-openvpn network-manager-pptp network-manager-pptp-gnome -y
sudo apt autoremove ubuntu-advantage-tools -y
sudo apt autoremove plymouth-label plymouth-theme-spinner va-driver-all -y


message "remove printer stuff..."
# remove printer drivers
sudo apt autoremove printer-driver-m2300w printer-driver-splix printer-driver-postscript-hp printer-driver-pxljr printer-driver-min12xxw -y
sudo apt autoremove printer-driver-pnm2ppa printer-driver-foo2zjs printer-driver-foo2zjs-common -y
sudo apt autoremove printer-driver-brlaser printer-driver-c2esp printer-driver-ptouch  printer-driver-c2esp -y
sudo apt autoremove printer-driver-sag-gdi printer-driver-hpcups system-config-printer-common system-config-printer-udev -y
sudo apt autoremove cups-browsed cups-filters-core-drivers cups cups-bsd cups-client cups-common -y
sudo apt autoremove cups-browsed printer-driver-hpcups libcupsfilters1 openprinting-ppds -y



message "remove fonts..."
sudo apt-get autoremove gnome-font-viewer "fonts-kacst*" "fonts-khmeros*" fonts-lklug-sinhala fonts-guru-extra "fonts-nanum*"  -y
sudo apt-get autoremove fonts-noto-cjk "fonts-takao*" fonts-tibetan-machine fonts-lao fonts-sil-padauk fonts-sil-abyssinica  -y
sudo apt-get autoremove "fonts-tlwg-*" "fonts-lohit-*" fonts-beng-extra fonts-gargi fonts-gubbi fonts-gujr-extra fonts-kalapi   -y
sudo apt-get autoremove "fonts-samyak*" fonts-tlwg-typo-ttf fonts-navilu fonts-nakula fonts-orya-extra  -y
sudo apt-get autoremove fonts-pagul fonts-sarai "fonts-telu*" "fonts-wqy*" "fonts-smc*" fonts-deva-extra fonts-sahadeva  -y


# kernel cleanup

message "kernel cleanup..."
dpkg -l linux-* | awk '/^ii/{ print $2}' | grep -v -e `uname -r | cut -f1,2 -d"-"` | grep -e [0-9] | xargs sudo apt-get -y purge



# make it possible to disable uneeded startup apps

message "disable autostart for default stuff. start 'gnome-session-properties' to configure .... "
mkdir -p ~/.config/autostart/
sudo sed -i -e 's/NoDisplay=true/NoDisplay=false/' /etc/xdg/autostart/*
cp /etc/xdg/autostart/* ~/.config/autostart/
sudo sed -i -e 's/X-GNOME-Autostart-enabled=true/X-GNOME-Autostart-enabled=false/' ~/.config/autostart/*
sudo sed -i -e 's/NoDisplay=true/NoDisplay=false/' ~/.config/autostart/*
sudo sed -i -e 's/X-GNOME-AutoRestart=true/X-GNOME-AutoRestart=false/' ~/.config/autostart/*
sudo sed -i -e 's/X-GNOME-Autostart-Notify=true/X-GNOME-Autostart-Notify=false/' ~/.config/autostart/*



message "Disabling services... "
systemctl list-unit-files --state=enabled | wc -l
sudo systemctl mask  bluetooth.service
sudo systemctl --reverse list-dependencies cups.service
sudo systemctl disable cups.service cups.socket cups.path
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
# sudo systemctl mask systemd.networkd.service
sudo systemctl mask packagekit.service
sudo systemctl stop whoopsie.service  
sudo systemctl mask whoopsie.service  

systemctl list-unit-files --state=enabled | wc -l

# disable animations and  background image to save mem
message "setting default ui options to save memory..."
gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.desktop.background primary-color '#000455'
gsettings set org.gnome.desktop.interface enable-animations false

cat > ~/.config/gtk-3.0/settings.ini << eof
[Settings]
gtk-application-prefer-dark-theme=1
eof

# other ui stuff
message "setting other ui options..."
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.shell.overrides attach-modal-dialogs false  # modals don't "stick" to parent window
# gsettings set org.gnome.shell enable-hot-corners true
gsettings set org.gnome.settings-daemon.plugins.print-notifications active false

# disable some hardware-stuff not needed in virtualbox
message "disabling hardware..."
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

# gsettings set org.gtk.Settings.F show-hidden true
# Experimental - start
message "Experimental - start..."
sudo mv /usr/lib/evolution-data-server /usr/lib/evolution-data-server-disabled
sudo mv /usr/lib/evolution-addressbook-factory /usr/lib/evolution-addressbook-factory-disabled
sudo mv /usr/libexec/evolution-calendar-factory /usr/libexec/evolution-calendar-factory-disabled
sudo mv /usr/libexec/evolution-source-registry /usr/libexec/evolution-source-registry-disabled
sudo mv /usr/libexec/evolution-data-server/evolution-alarm-notify /usr/libexec/evolution-data-server/evolution-alarm-notify-disabled

# disable modules stuff
# btusb : bluetooth usb
# pcspkr  pc speaker 
# usbmouse : these drivers are very simple, the HID drivers are usually preferred
# usbkbd : these drivers are very simple, the HID drivers are usually preferred
# eepro100 : replaced by e100
# de4x5 : replaced by tulip
# eth1394: causes no end of confusion by creating unexpected network interfaces
# snd_intel8x0m: snd_intel8x0m can interfere with snd_intel8x0, doesn't seem to support much  hardware on its own (Ubuntu bug #2011, #6810)
# snd_aw2: Conflicts with dvb driver (which is better for handling this device)
# i2c_i801: causes failure to suspend on HP compaq nc6000 (Ubuntu: #10306)
# prism54: replaced by p54pci
# bcm43xx: replaced by b43 and ssb.
# garmin_gps: most apps now use garmin usb driver directly (Ubuntu: #114565)
# asus_acpi: replaced by asus-laptop (Ubuntu: #184721)
# snd_pcsp: low-quality, just noise when being used for sound playback, causes  hangs at desktop session start (Ubuntu: #246969)
# amd76x_edac: EDAC driver for amd76x clashes with the agp driver preventing the aperture from being initialised (Ubuntu: #297750). Blacklist so that the driver continues to build and is installable for the few cases where its really needed.
# uvcvideo: Disable webcam
# parport_pc : disable parallel port
# ppdev : disable ?
# lp : disable ?
# parport: disable parallel port
# input_leds
# joydev : joystick driver
# ns558 : joystick driver

modules=("btusb" "uvcvideo" "parport_pc" "ppdev" "lp" "parport" "input_leds" "joydev")

for MOD in "${modules[@]}"; do
  CURRENT_CMD="sudo echo 'blacklist $MOD' | sudo tee /etc/modprobe.d/blacklist-$MOD.conf"
  eval $CURRENT_CMD
done
# Experimental - end

message "journalctl optimalization..."
# journalctl optimalization
sudo journalctl --vacuum-size=300M --vacuum-time=2d --vacuum-files=5
#sudo rm /var/log/ -r

message " Adjust swappiness..."
sudo bash -c 'echo "vm.swappiness=10" >>  /etc/sysctl.d/99-sysctl.conf'

message "Disabling firewall logging..."
sudo ufw logging off


apt list --installed | sed  "s/\/focal.*//g" > /tmp/apt-list-installed.txt
message "Done!"
