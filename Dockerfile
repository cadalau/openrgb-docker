FROM debian:buster-slim

ENV INSTALL_PATH openrgb_docker
WORKDIR $INSTALL_PATH
RUN apt-get update

RUN apt-get -y install sudo

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER docker

COPY dockerrun.sh /usr/local/bin/dockerrun.sh

RUN sudo apt -y install git qt5-default libusb-1.0-0-dev libhidapi-dev i2c-tools kmod
RUN sudo apt-get -y install build-essential
RUN sudo git clone https://gitlab.com/CalcProgrammer1/OpenRGB && cd OpenRGB && sudo git submodule update --init --recursive && sudo qmake OpenRGB.pro && sudo make -j8
CMD ["bash", "dockerrun.sh"]
