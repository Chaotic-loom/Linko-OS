#!/bin/bash

# Only if the flag does not exists
if [ ! -f /boot/firstboot_done ]; then
    # Expand rootfs (Expand sd card size)
    raspi-config --expand-rootfs

    # Grant permissions
    usermod -a -G video,render,netdev player
    chmod 755 /opt/linko/

    # Create flag and reboot
    touch /boot/firstboot_done
    sync
    echo b > /proc/sysrq-trigger
fi