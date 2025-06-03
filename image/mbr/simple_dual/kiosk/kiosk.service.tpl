[Unit]
Description=Kiosk Wayland Session
After=multi-user.target

[Service]
Type=simple
User=<KIOSK_USER>

TTYPath=/dev/tty1
StandardInput=tty
StandardOutput=inherit
StandardError=inherit

Environment="XDG_RUNTIME_DIR=<KIOSK_RUNDIR>"
Environment="DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u <KIOSK_USER>)/bus"

Restart=no
TimeoutStartSec=infinity
ExecStart=/usr/local/bin/kiosk-launcher.sh
StandardError=journal

TTYReset=yes
TTYVHangup=yes

[Install]
WantedBy=default.target