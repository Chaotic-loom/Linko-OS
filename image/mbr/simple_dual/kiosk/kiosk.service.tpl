[Unit]
Description=Kiosk Wayland Session
After=multi-user.target

[Service]
User=<KIOSK_USER>
TTYPath=/dev/tty1
Environment="XDG_RUNTIME_DIR=<KIOSK_RUNDIR>"
Restart=on-failure
RestartSec=2
StartLimitIntervalSec=0
StartLimitBurst=5
ExecStart=/usr/bin/cage -- <KIOSK_APP>
StandardError=journal

[Install]
WantedBy=default.target