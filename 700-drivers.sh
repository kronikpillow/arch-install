#!/bin/sh
sudo pacman -S --needed lib32-mesa \
	mesa-utils \
	lib32-mesa-utils \
	xf86-video-amdgpu \
	vulkan-radeon \
	lib32-vulkan-radeon \
	libva-mesa-driver \
	lib32-libva-mesa-driver \
	mesa-vdpau \
	lib32-mesa-vdpau \
	opencl-mesa \
	lib32-opencl-mesa \
	libva-utils \
	vdpauinfo
