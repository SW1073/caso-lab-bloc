#!/bin/bash

DISK=25G
MEMORY=4G
THREADS=4

if ! [ -f "Image.img" ]; then
    echo "Image.img not found. Creating a new one."
    echo "Creating a $DISK image file."
    qemu-img create -f qcow2 Image.img 25G
    echo "Running QEMU with $MEMORY of memory and $THREADS threads to install the ISO into the image."
    qemu-system-x86_64 \
        -enable-kvm \
        -cdrom ubuntu-20.04.6-desktop-amd64.iso\
        -drive file=Image.img \
        -m $MEMORY \
        -smp $THREADS \
        -boot menu=on \
        -cpu host \
        -vga virtio -display gtk,gl=on
fi

echo "Running QEMU with $MEMORY of memory and $THREADS threads without the ISO. Booting from the image."
qemu-system-x86_64 \
    -enable-kvm \
    -drive file=Image.img \
    -m $MEMORY \
    -smp $THREADS \
    -boot menu=on \
    -cpu host \
    -vga virtio -display gtk,gl=on


