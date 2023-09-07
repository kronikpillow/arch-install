#!/bin/sh

echo "pacstrapping the base system"
pacstrap /mnt base \
base-devel \
linux \
linux-firmware \
intel-ucode \
mtools \
dosfstools \
exfatprogs \
ntfs-3g \
btrfs-progs \
reiserfsprogs \
efibootmgr \
grub \
os-prober \
man-db \
man-pages \
texinfo \
bash-completion \
zsh \
zsh-completions \
python \
python-pip \
nodejs \
npm \
go \
go-tools \
rust \
cargo \
neovim \
lf \
git \
rsync \
wget \
plocate \
pkgfile \
reflector \
cronie \
dbus-broker \
polkit \
pacman-contrib \
pacutils \
arch-install-scripts \
pigz \
pbzip2 \
alsa-firmware \
alsa-plugins \
alsa-utils \
wireplumber \
pipewire-alsa \
pipewire-jack \
pipewire-pulse \
gst-plugin-pipewire \
rtkit \
zram-generator \
networkmanager \
firewalld \
xf86-video-amdgpu \
grub-btrfs \
inotify-tools \
snapper \
snap-pac

sleep 5

echo "generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab
printf "\e[1;32mDone! \e[0m"
