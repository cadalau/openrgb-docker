#FROM debian:jessie
FROM ubuntu:18.04

# Pull base image.
#FROM jlesage/baseimage-gui:ubuntu-18.04


# Install xterm.
#RUN add-pkg xterm

# Set the name of the application.
#ENV APP_NAME="Xterm"


#FROM x11docker/deepin
#ARG DISPLAY

RUN apt-get update
WORKDIR /root
COPY dockerrun.sh /usr/local/bin/dockerrun.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apt -y install git qt5-default libusb-1.0-0-dev libhidapi-dev i2c-tools kmod build-essential libgl1-mesa-dev libseccomp2 x11vnc xvfb
RUN git clone https://gitlab.com/GaryPate/OpenRGB.git && cd OpenRGB && git submodule update --init --recursive
WORKDIR /root/OpenRGB
RUN pwd
RUN ls -la
RUN qmake OpenRGB.pro
RUN make
EXPOSE 5920
CMD ["bash", "dockerrun.sh"]
ENTRYPOINT ["entrypoint.sh"]

