#!/bin/sh

cp -r etc/docker/* /etc/
cp -r etc/pacman.d/* /etc/pacman.d/
cp -r etc/pam.d/* /etc/pam.d/
cp -r etc/polkit-1/* /etc/polkit-1/
cp -r etc/snapper/* /etc/snapper/
cp -r etc/sudoers.d/* /etc/sudoers.d/
#cp -r etc/sysctl.d/* /etc/sysctl.d/
cp -r etc/systemd/* /etc/systemd/
cp -r etc/xdg/* /etc/xdg/
chmod +x usr/local/bin/powertune
cp -r usr/* /usr/

timedatectl set-timezone Europe/Belgrade
timedatectl set-ntp true

systemctl enable dbus-broker.service
systemctl start dbus-broker.service

systemctl enable NetworkManager.service
systemctl start NetworkManager.service

systemctl enable cronie.service
systemctl start cronie.service

systemctl enable grub-btrfsd.service
systemctl start grub-btrfsd.service

systemctl enable fstrim.timer
systemctl start fstrim.timer

systemctl enable pkgfile-update.timer
systemctl start pkgfile-update.timer

systemctl enable reflector.timer
systemctl start reflector.timer
systemctl start reflector.service

systemctl enable powertune.service
systemctl start powertune.service

# systemctl enable ufw.service

# ufw default deny incoming
# ufw default allow outgoing
# ufw limit 22
# ufw limit 2222
# ufw allow 80
# ufw allow 443
# ufw allow Transmission
# ufw allow qBittorrent
# ufw enable

# systemctl enable snapper-timeline.timer
# systemctl start snapper-timeline.timer

# systemctl enable snapper-cleanup.timer
# systemctl start snapper-cleanup.timer
