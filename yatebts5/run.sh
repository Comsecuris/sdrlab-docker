#!/bin/sh

NAME=`basename $PWD`

docker run -t -i -h yatebts5 --privileged -v /dev/bus/usb:/dev/bus/usb -h $NAME $NAME
