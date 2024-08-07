#!/bin/bash

backup_files=("/etc/mkinitcpio.conf")

for file in "${backup_files[@]}"; do
  if [ ! -f "$file.bak" ]; then
    cp "$file" "$file.bak" && printf "\e[1;33m%s backed up\e[0m\n" "$file"
  else
    printf "\e[1;33m%s already backed up\e[0m\n" "$file"
  fi
done

echo "Configuring mkinitcpio settings"
sed -i -e "7 s/.*/MODULES=(btrfs amdgpu)/" \
	-e "14 s/.*/BINARIES=(\/usr\/bin\/btrfs)/" \
	-e "19 s/.*/FILES=()/" \
	-e "55 s/.*/HOOKS=(base systemd autodetect microcode modconf kms keyboard sd-vconsole block filesystems fsck grub-btrfs-overlayfs)" /etc/mkinitcpio.conf.d/mkinitcpio.conf

mkinitcpio -P

printf "\e[1;32m%s\e[0m\n" "Done!"
