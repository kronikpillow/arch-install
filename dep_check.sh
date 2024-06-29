#!/bin/bash
# This script cross-references each package in the list with each other, and removes any direct dependencies
# List of packages to check for dependencies
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
 texinfo 
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

# Array to hold packages that are dependencies
dependencies=()

# Check each package for being a dependency of any other package in the list
for pkg in  ${packages[@]} ; do
	# Check if the package exists
	pacman -Si  $pkg  >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		echo  Package  $pkg\  does not exist. 
		continue
	fi

	# Fetch only the direct dependencies of the package
	direct_deps=$(pacman -Si  $pkg  2>/dev/null | sed -n 's/Depends On      : //p')
	for dep in $direct_deps; do
		dependencies+=( $dep )
	done
done

# Remove duplicates
dependencies=($(echo  ${dependencies[@]}  | tr ' ' '\n' | sort -u))

# Print out the packages that are not dependencies
echo  Packages you need to explicitly install: 
for pkg in  ${packages[@]} ; do
	if [[ !   ${dependencies[@]}   =~   ${pkg}   ]]; then
		echo     $pkg\  
	fi
done
