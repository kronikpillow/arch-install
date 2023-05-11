#!/bin/sh
yay -Sy --needed mesa \
  mesa-demos \
  xf86-video-amdgpu \
	vulkan-radeon \
  vulkan-tools \
	libva-mesa-driver \
	libva-utils \
	mesa-vdpau \
	libva-vdpau-driver \
  libvdpau-va-gl \
	vdpauinfo \
	mesa-utils \
	opencl-mesa
	# vulkan-mesa-layers \

yay -Sy --needed lib32-mesa \
  lib32-glu \
	lib32-vulkan-radeon \
	lib32-libva-mesa-driver \
	lib32-mesa-vdpau \
	lib32-libva-vdpau-driver \
  lib32-libvdpau-va-gl \
	lib32-mesa-utils \
	lib32-opencl-mesa
	# lib32-vulkan-mesa-layers
