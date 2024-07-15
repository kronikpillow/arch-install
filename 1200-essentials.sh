#!/bin/bash

# Audio packages
audio_packages=(
  gst-libav
  gst-plugins-bad
  gst-plugins-base
  gst-plugins-good
  gst-plugins-ugly
  gst-plugin-pipewire
  gst-plugin-gtk
  gst-plugin-libcamera
  gstreamer
  gstreamer-vaapi
  libdvdcss
  noise-suppression-for-voice
  helvum
  pulsemixer
  lib32-pipewire
  lib32-pipewire-jack
  lib32-gst-plugins-base
  lib32-gst-plugins-base-libs
  lib32-gst-plugins-good
  lib32-gstreamer
)

# System and utility packages
system_utility_packages=(
  lf
  pacman-contrib
  pacutils
  inxi
  powertop
  iotop
  schedtool
  usbutils
  lsof
  strace
  hdparm
  pigz
  pbzip2
  lrzip
  ncompress
  lzip
  quota-tools
  plocate
  expac
  atool
  cpio
  lhasa
  lzop
  p7zip
  unace
  unrar
  zip
  unzip
  lynx
  fd
  ripgrep
  fzf
  socat
  xclip
)

# Media and productivity packages
media_productivity_packages=(
  ffmpeg
  mpv
  yt-dlp
  mediainfo
)

#  mpd
#  mpc
#  ncmpcpp
#  newsboat
#  wl-clipboard
#  xdotool
#  zathura
#  zathura-pdf-mupdf
#  poppler
#  task-spooler
#  moreutils
#  viewnior

# Install packages using arrays
sudo pacman -Sy --needed \
"${audio_packages[@]}" \
"${system_utility_packages[@]}" \
"${media_productivity_packages[@]}"
