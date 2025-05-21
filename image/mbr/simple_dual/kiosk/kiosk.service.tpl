[Unit]
Description=Kiosk Wayland Session
After=multi-user.target

[Service]
User=<KIOSK_USER>
SupplementaryGroups=netdev video
TTYPath=/dev/tty1
Environment="XDG_RUNTIME_DIR=<KIOSK_RUNDIR>"
Restart=always
RestartSec=3
ExecStart=/usr/bin/cage -- <KIOSK_APP>
StandardError=journal

[Install]
WantedBy=default.target