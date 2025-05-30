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
ExecStart=/bin/sh -c '\
  exec Xorg :0 -nolisten tcp vt1 \
    && sleep 1 \
    && su -l %u -c "matchbox-window-manager --use_cursor_keys & \
                     <KIOSK_APP>"'
StandardError=journal

[Install]
WantedBy=default.target