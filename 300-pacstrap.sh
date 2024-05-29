#!/bin/bash
set -e  # Exit on error

# Function to install packages
pacstrap_base() {
  echo "Pacstrapping the base system"

packages=(
 base
 base-devel
 linux
 linux-firmware
 intel-ucode
 mtools
 dosfstools
 exfatprogs
 xfsprogs
 reiserfsprogs
 ntfs-3g
 efibootmgr
 os-prober
 man-db
 man-pages
 bash-completion
 zsh-completions
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
 reflector
 fcron
 dbus-broker
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
 snap-pac
)

  pacstrap /mnt "${packages[@]}"

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
