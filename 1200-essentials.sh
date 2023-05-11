###audio
# yay -Sy --needed --noconfirm alsa-firmware \
#   alsa-plugins \
#   alsa-utils \
#   wireplumber \
#   pipewire-alsa \
#   pipewire-jack \
#   pipewire-pulse \
#   rtkit

yay -Sy --needed --noconfirm gst-libav \
  gst-plugins-bad \
  gst-plugins-base \
  gst-plugins-good \
  gst-plugins-ugly \
  gst-plugin-pipewire \
  gst-plugin-gtk \
  gst-plugin-libcamera \
  gstreamer \
  gstreamer-vaapi \
  libdvdcss \
  pavucontrol \
  pulsemixer

yay -Sy --needed --noconfirm lib32-pipewire \
  lib32-pipewire-jack \
  lib32-gst-plugins-base \
  lib32-gst-plugins-base-libs \
  lib32-gst-plugins-good \
  lib32-gstreamer

###file management
# yay -Sy --needed --noconfirm gvfs \
#   gvfs-afc \
#   gvfs-gphoto2 \
#   gvfs-mtp \
#   gvfs-nfs \
#   gvfs-smb \
#   mtpfs \
#   udiskie \
#   udisks2 \
#   xdg-user-dirs

###printers
# yay -Sy --needed cups \
#   cups-filters \
#   cups-pdf \
#   ghostscript \
#   gsfonts \
#   gutenprint \
#   system-config-printer

###tumbler
pacman -Sy --needed --noconfirm  tumbler \
  ffmpegthumbnailer \
  freetype2 \
  libgsf \
  libopenraw \
  poppler-glib \
  poppler-qt5

pacman -Sy --needed --noconfirm lf \
  pacman-contrib \
  pacutils \
  inxi \
  powertop \
  radeontop \
  iotop \
  schedtool \
  usbutils \
  lsof \
  strace \
  hdparm \
  pigz \
  pbzip2 \
  quota-tools \
  mlocate \
  expac \
  atool \
  cpio \
  lha \
  lzop \
  p7zip \
  unace \
  unrar \
  zip \
  unzip \
  lrzip \
  ncompress \
  lzip \
  autoconf-archive \
  cmake \
  jsoncpp \
  rhash \
  # linux-tools \

yay -Sy --needed --noconfirm mpd \
  mpv \
  mpc \
  ncmpcpp \
  newsboat \
  abook \
  lynx \
  xclip \
  wl-clipboard \
  xdotool \
  yt-dlp \
  zathura \
  zathura-pdf-mupdf \
  poppler \
  mediainfo \
  fzf \
  bat \
  task-spooler \
  simple-mtpfs \
  htop-vim \
  mutt-wizard-git \
  socat \
  moreutils \
