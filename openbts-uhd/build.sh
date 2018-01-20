#!/bin/sh
NAME=`basename $PWD`

docker build -t $NAME .
