#!/bin/bash
sudo modprobe i2c_dev i2c_piix4
sudo chmod 777 /dev/i2c-4
sudo OpenRGB/OpenRGB
