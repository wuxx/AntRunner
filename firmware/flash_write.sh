#!/bin/bash

ESPTOOL=esptool.py


#SER_PORT=COM32 #on windows with git-bash

SER_PORT=/dev/ttyUSB0
#SER_PORT=/dev/ttyUSB1
#SER_PORT=/dev/ttyACM0

BAUDRATE=460800

IMAGE=flash_image_20220821.bin

echo "write [$IMAGE]"

${ESPTOOL} \
        --chip esp32 \
        -p ${SER_PORT} \
        -b ${BAUDRATE} \
        --before=default_reset \
        --after=hard_reset \
        write_flash \
        --flash_mode dio \
        --flash_freq 40m \
        --flash_size 4MB \
        0x0 ${IMAGE}

