#!/bin/sh

NAME=`basename $PWD`

docker run -t -i --privileged -v /dev/bus/usb:/dev/bus/usb -h $NAME $NAME
