#FROM debian:jessie
#FROM python:3.7-buster
FROM ubuntu:18.04
#FROM phusion/baseimage
#FROM ubuntu:16.04

ENV TZ=Australia/Sydney
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update --fix-missing
WORKDIR /root
COPY dockerrun.sh /usr/local/bin/dockerrun.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENV PYTHONPATH="/usr/local/bin"
#RUN apt -y install python3
#CMD ["which python"]
#RUN which python
#RUN echo $PYTHONPATH
#RUN apt -y install python


#RUN apt -y install python
RUN apt -y install python git qt5-default libusb-1.0-0-dev libhidapi-dev i2c-tools build-essential libgl1-mesa-dev libseccomp2 x11vnc xvfb

RUN git clone https://gitlab.com/GaryPate/OpenRGB.git && cd OpenRGB && git submodule update --init --recursive
RUN git clone https://github.com/novnc/noVNC && ln -s /root/noVNC/vnc_lite.html /root/noVNC/index.html
RUN git clone https://github.com/novnc/websockify

#RUN wget -O - https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar -xzv -C /root/ && mv /root/noVNC-1.1.0 /root/novnc && ln -s /root/novnc/vnc_lite.html /root/novnc/index.html
#RUN wget -O - https://github.com/novnc/websockify/archive/v0.8.0.tar.gz | tar -xzv -C /root/ && mv /root/websockify-0.8.0 /root/novnc/utils/websockify

WORKDIR /root/OpenRGB
RUN qmake OpenRGB.pro
RUN make
EXPOSE 6080
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

