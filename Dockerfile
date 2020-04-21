
FROM ubuntu:18.04
ENV TZ=Australia/Brisbane
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update --fix-missing
WORKDIR /root
COPY dockerrun.sh /usr/local/bin/dockerrun.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENV PYTHONPATH="/usr/local/bin"
RUN apt -y install python-numpy git qt5-default libusb-1.0-0-dev libhidapi-dev libssl-dev i2c-tools build-essential libgl1-mesa-dev libseccomp2 x11vnc xvfb net-tools
RUN git clone https://gitlab.com/CalcProgrammer1/OpenRGB.git && cd OpenRGB && git submodule update --init --recursive
RUN git clone https://github.com/novnc/noVNC && ln -s /root/noVNC/vnc_lite.html /root/noVNC/index.html
WORKDIR /root/OpenRGB
RUN qmake OpenRGB.pro
RUN make
EXPOSE 6080
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

