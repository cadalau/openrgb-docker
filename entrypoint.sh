#!/bin/bash
# entrypoint.sh file for starting the xvfb with better screen resolution, configuring and running the vnc server, pulling the code from git and then running the test.


#Xvfb :20 -screen 0 1024x768x16 -ac -l &
#Xvfb -screen 0 1024x768x16 -ac &
export DISPLAY=:99
xvfb-run --listen-tcp --auth-file /tmp/xvfb.auth --server-args="-screen 0 1024x768x16 -ac" ./OpenRGB &
chmod 755 /tmp/xvfb.auth
sleep 1
#xvfb-run -l ./OpenRGB
#x11vnc -display :20 -N -forever &
#x11vnc -display :20 -noipv6 -rawfb &
#x11vnc -display :20 -forever -nopw -localhost -auth /tmp/xvfb.auth
x11vnc -display :99 -N -forever -passwd orgb -shared -auth /tmp/xvfb.auth &
#cd /root/noVNC && ln -s vnc_auto.html index.html && ./utils/launch.sh --vnc localhost:5999

/root/noVNC/utils/launch.sh --vnc localhost:5999 --listen 6080
#export DISPLAY=:20
#./OpenRGB
#wait