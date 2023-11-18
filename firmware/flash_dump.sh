#!/bin/bash

esptool.py -b 115200 -p /dev/ttyUSB0 read_flash 0x0 0x400000 flash_image.bin

