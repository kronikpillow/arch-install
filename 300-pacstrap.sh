#!/bin/bash
set -e  # Exit on error

# Function to install packages
pacstrap_base() {
  echo "Pacstrapping the base system"

packages=(
base
base-devel
linux-zen
linux-firmware
intel-ucode
mtools
dosfstools
exfatprogs
ntfs-3g
btrfs-progs
reiserfsprogs
efibootmgr
grub
os-prober
man-db
man-pages
texinfo
bash-completion
zsh
zsh-completions
fish
python
nodejs
npm
go
go-tools
rust
neovim
lf
git
rsync
wget
plocate
pkgfile
fcron
dbus-broker
polkit
pacman-contrib
pacutils
arch-install-scripts
pigz
pbzip2
alsa-utils
wireplumber
pipewire-alsa
pipewire-jack
pipewire-pulse
gst-plugin-pipewire
rtkit
zram-generator
networkmanager
firewalld
grub-btrfs
inotify-tools
snapper
snap-pac
)

  pacman -Sy --needed "${packages[@]}"

  echo "Pacstrap complete."
}

# Function to modify grub files
modify_grub_files() {
  # List of files to modify
  files=("/etc/grub.d/10_linux" "/etc/grub.d/20_linux_xen")

  # Loop through each file
  for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
      echo "Modifying $file"
      sed -i 's/rootflags=subvol=${rootsubvol} //g' "$file"
      echo "Modification complete for $file."
    else
      echo "File $file does not exist."
    fi
  done
}

# Function to generate fstab
generate_fstab() {
  echo "Generating fstab"
  genfstab -U /mnt >> /mnt/etc/fstab
  printf "\e[1;32mDone! \e[0m"
}

# Main script logic
pacstrap_base
modify_grub_files
generate_fstab

echo "Script completed."
