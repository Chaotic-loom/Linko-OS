[Unit]
Description=Kiosk Wayland Session
After=multi-user.target

[Service]
User=<KIOSK_USER>
TTYPath=/dev/tty1
Environment="XDG_RUNTIME_DIR=<KIOSK_RUNDIR>"
Environment="DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u <KIOSK_USER>)/bus"
Restart=always
RestartSec=3
ExecStart=/usr/bin/cage -- <KIOSK_APP>
StandardError=journal

[Install]
WantedBy=default.target