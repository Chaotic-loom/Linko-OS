#!/bin/bash
# Grant permissions
usermod -a -G video,render,netdev player
chmod 755 /opt/linko/

# Expand rootfs (Expand sd card size)
if [ ! -f /boot/firstboot_done ]; then
    raspi-config --expand-rootfs
    touch /boot/firstboot_done
    sync
    echo b > /proc/sysrq-trigger
fi