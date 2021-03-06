#!/bin/sh
sudo pacman -S --needed lib32-mesa \
	xf86-video-amdgpu \
	vulkan-radeon \
	lib32-vulkan-radeon \
	libva-mesa-driver \
	lib32-libva-mesa-driver \
	libva-utils \
	mesa-vdpau \
	lib32-mesa-vdpau \
	libva-vdpau-driver \
	lib32-libva-vdpau-driver \
	vdpauinfo \
	mesa-utils \
	lib32-mesa-utils \
	opencl-mesa \
	lib32-opencl-mesa
