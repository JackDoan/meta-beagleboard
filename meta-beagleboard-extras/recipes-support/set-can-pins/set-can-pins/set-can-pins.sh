#!/bin/sh

PINNUM=115

OPERATION=$1

GPIOPATH="/sys/class/gpio$PINNUM"

case $OPERATION in
	start)
		echo $PINNUM > /sys/class/gpio/export
		echo out > $GPIOPATH/direction
		echo 0 > $GPIOPATH/value
		echo "CAN buffer enabled"
		;;
	stop)
		echo 0 > $GPIOPATH/value
		echo in > $GPIOPATH/direction
		echo $PINNUM > /sys/class/gpio/unexport
		echo "CAN buffer disabled"
		;;
	*)
		echo "$0 [start|stop]"
		;;
esac

