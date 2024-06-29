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
 ntfs-3g
 btrfs-progs
 reiserfsprogs
 efibootmgr
 grub
 os-prober
 man-db
 man-pages
 bash
 bash-completion
 zsh
 zsh-completions
 python
 python-pip
 python-pipx
 nodejs
 npm
 go
 go-tools
 rust
 ruby
 ruby-irb
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
 polkit
 pacman-contrib
 pacutils
 arch-install-scripts
 pigz
 pbzip2
 alsa-firmware
 alsa-plugins
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

  pacstrap /mnt/opensuse "${packages[@]}"

  echo "Pacstrap complete."
}

backup_grub_d() {
	# List of files to backup
	grub_d_backup=("/mnt/opensuse/etc/grub.d/10_linux" "/mnt/opensuse/etc/grub.d/20_linux_xen")

	for file in "${grub_d_backup[@]}"; do
		if [ ! -f "$file.bak" ]; then
			cp "$file" "$file.bak" && printf "\e[1;33m%s backed up\e[0m\n" "$file"
		else
			printf "\e[1;33m%s already backed up\e[0m\n" "$file"
		fi
	done
}

# Function to modify grub files
modify_grub_d() {
	# List of files to modify
	grub_d_modify=("/mnt/opensuse/etc/grub.d/10_linux" "/mnt/opensuse/etc/grub.d/20_linux_xen")
	# Loop through each file
	for file in "${grub_d_modify[@]}"; do
		if [[ -f "$file" ]]; then
			echo "Modifying $file"
			sed -i 's/rootflags=subvol=${rootsubvol}//g' "$file"
			echo "Modification complete for $file."
		else
			echo "File $file does not exist."
		fi
	done
}

# Function to generate fstab
generate_fstab() {
	echo "Generating fstab"
	genfstab -U /mnt/opensuse >> /mnt/opensuse/etc/fstab
	printf "\e[1;32mDone! \e[0m"
}

backup_fstab() {
	# List of files to backup
	fstab_backup=("/mnt/opensuse/etc/fstab")

	for file in "${fstab_backup[@]}"; do
		if [ ! -f "$file.bak" ]; then
			cp "$file" "$file.bak" && printf "\e[1;33m%s backed up\e[0m\n" "$file"
		else
			printf "\e[1;33m%s already backed up\e[0m\n" "$file"
		fi
	done
}

# Function to modify fstab
modify_fstab() {
	# List of files to modify
	fstab_modify=("/mnt/opensuse/etc/fstab")
	# Loop through each file
	for file in "${fstab_modify[@]}"; do
		if [[ -f "$file" ]]; then
			echo "Modifying $file"
			sed -i 's/subvolid=.*,//' "$file"
			echo "Modification complete for $file."
		else
			echo "File $file does not exist."
		fi
	done
}

# Main script logic
pacstrap_base
backup_grub_d
modify_grub_d
generate_fstab
backup_fstab
modify_fstab

echo "Script completed."
