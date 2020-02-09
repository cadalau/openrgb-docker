#!/bin/bash
export DISPLAY=:99
xvfb-run --listen-tcp --auth-file /tmp/xvfb.auth --server-args="-screen 0 1024x768x16 -ac" ./OpenRGB &
sleep 1
chmod 755 /tmp/xvfb.auth
sleep 1
x11vnc -display :99 -N -forever -passwd orgb -shared -auth /tmp/xvfb.auth &
sleep 1
/root/noVNC/utils/launch.sh --vnc localhost:5999 --listen 6080