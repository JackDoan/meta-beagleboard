#!/bin/sh

PINNUM=115

OPERATION=$1

GPIOPATH="/sys/class/gpio/gpio$PINNUM"

case $OPERATION in
	start)
		echo $PINNUM > /sys/class/gpio/export
		echo out > $GPIOPATH/direction
		echo 1 > $GPIOPATH/value
		echo "CAN buffer enabled"
		#this doesnt really go here, but it works
		ip link set down can0
		ip link set can0 type can bitrate 500000
		ip link set up can0
		ip link set down can1
		ip link set can1 type can bitrate 500000
		ip link set up can1

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

