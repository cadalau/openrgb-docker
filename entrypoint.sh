#!/bin/bash
export DISPLAY=:99
xvfb-run --listen-tcp --auth-file /tmp/xvfb.auth --server-args="-screen 0 1024x768x16 -ac" ./OpenRGB &
sleep 1
chmod 755 /tmp/xvfb.auth
sleep 1
x11vnc -display :99 -N -forever -passwd orgb -shared -auth /tmp/xvfb.auth &
#x11vnc -display :99 -N -passwd orgb -shared -auth guess &
sleep 1
/root/noVNC/utils/launch.sh --vnc localhost:5999 --listen 6080

#openssl req -x509 -nodes -newkey rsa:2048 -keyout novnc.pem -out novnc.pem -days 365
#openssl req \
#    -new \
#    -newkey rsa:4096 \
#    -days 365 \
#    -nodes \
#    -x509 \
#    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.nan.com" \
#    -keyout www.nan.com.key \
#    -out www.nan.com.cert

#/usr/share/novnc/utils/launch.sh --vnc localhost:5999 --listen 6080

#websockify 6080 --wrap-mode=ignore -- vncserver
#websockify -D --web=/usr/share/novnc/utils/launch.sh 6080 localhost:5999  #--cert=/etc/ssl/novnc.pem