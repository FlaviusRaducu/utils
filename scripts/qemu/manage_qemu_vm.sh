#!/bin/bash
# virtio drivers need to be installed on guest os

if [[ $# -ne 1 ]]; then
    echo "Please enter at least an argument: create, install, start"
    exit 1


elif [[ "$1" == "create" ]]; then
    echo "Creating qemu disk..."
    read -p "Please enter disk name: " disk_name
    read -p "Please enter disk size, e.g. 15G: " disk_size
    qemu-img create -f qcow2 "$disk_name".qcow2 "$disk_size"
    exit 0


elif [[ "$1" == "install" ]]; then
    echo "Installing image on disk..."
    read -p "Please enter disk path: " disk_path
    read -p "Please enter image path: " img_path
    read -p "Please enter image ram, e.g. 4G: " img_ram
    read -p "Please enter image nr of vCPUs, e.g. 4: " img_vcpus
    read -p "Please enter image accel mode, e.g. hvf, whpx, kvm: " accel

    qemu-system-x86_64 \
    -m "$img_ram" \
    -smp "$img_vcpus" \
    -cdrom "$img_path" \
    -drive file="$disk_path",if=virtio \
    -vga virtio \
    -usb \
    -cpu host \
    -machine type=q35,accel="$accel"
    exit 0


elif [[ "$1" == "start" ]]; then
    echo "Starting qemu vm..."
    read -p "Please enter disk path: " disk_path
    read -p "Please enter image ram, e.g. 4G: " img_ram
    read -p "Please enter image nr of vCPUs, e.g. 4: " img_vcpus
    read -p "Please enter image accel mode, e.g. hvf, whpx, kvm: " accel

    qemu-system-x86_64 \
    -m "$img_ram" \
    -smp "$img_vcpus" \
    -drive file="$disk_path",if=virtio \
    -vga virtio \
    -device usb-tablet \
    -usb \
    -cpu host \
    -machine type=q35,accel="$accel"
    exit 0
fi

