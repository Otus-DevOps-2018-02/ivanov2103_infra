#!/bin/bash
touch /etc/systemd/system/puma.service
cat << EOF > /etc/systemd/system/puma.service
[Unit]
Description=Puma Server
After=network.target
[Service]
Type=simple
User=appuser
Group=appuser
WorkingDirectory=/home/appuser/reddit/
ExecStart=/usr/local/bin/puma -C /home/appuser/reddit/config/deploy/production.rb
ExecStop=/bin/kill -s QUIT $MAINPID
TimeoutSec=15
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl enable puma
