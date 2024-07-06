#!/bin/sh
sudo pacman -Sy --needed mesa \
    vulkan-radeon \
    vulkan-tools \
    libva-mesa-driver \
    libva-utils \
    mesa-vdpau \
    libva-nvidia-driver \
    vdpauinfo \
    mesa-utils \
    vulkan-mesa-layers \
    opencl-clover-mesa

sudo pacman -Sy --needed lib32-mesa \
    lib32-glu \
    lib32-vulkan-radeon \
    lib32-libva-mesa-driver \
    lib32-mesa-vdpau \
    lib32-mesa-utils \
    lib32-vulkan-mesa-layers \
    lib32-opencl-clover-mesa
