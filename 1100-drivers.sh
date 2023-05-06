#!/bin/sh
pacman -Sy --needed xf86-video-amdgpu \
	vulkan-radeon \
	libva-mesa-driver \
	libva-utils \
	mesa-vdpau \
	libva-vdpau-driver \
	vdpauinfo \
	mesa-utils \
	opencl-mesa \
	vulkan-mesa-layers
