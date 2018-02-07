#!/bin/sh

NAME=`basename $PWD`

docker run -p 127.0.0.1:5038:5038 -t -i -h yatebts5 --privileged -v /dev/bus/usb:/dev/bus/usb $NAME bash
