#!/bin/bash
sleep 10
#pids=()
firstrun=1

pid_one=0
pid_two=0
pid_tree=0
pid_four=0

USB_Left_UP=false
USB_Left_Down=false
USB_Right_Up=false
USB_Right_Down=false

while true

do

sudo timeout 5s bash -c "nc -w 3 -n -vz 192.168.0.233 8000"
reply=$?
if [ $reply -eq 0 ];
	then
	printf "Ip found............................."
	if [ $firstrun -eq 1 ];
		then
		firstrun=0
		aplay -l | grep 'USB Sound Device' |grep 'USB_Right_UP'
                if [ $? -eq 0 ];
                        then
                        USB_Right_Up=true
                        timeout 5s alsa_out -d hw:USB_Right_UP
                        sudo darkice -c /home/pi/Desktop/USB_Right_UP.cfg &
                        pid_tree=$!
                        printf "\r\n$pid_tree....\r\n$USB_Right_Up.....\r\nUsb 3.....\r\n"
                        sleep 5
                fi
		aplay -l | grep 'USB Sound Device' |grep 'USB_Right_DOWN'
                if [ $? -eq 0 ];
                        then
                        USB_Right_Down=true
                        timeout 5s alsa_out -d hw:USB_Right_DOWN
                        sudo darkice -c /home/pi/Desktop/USB_Right_DOWN.cfg &
                        pid_four=$!
                        printf "\r\n$pid_four....\r\n$USB_Right_Down.....\r\nUsb 4.....\r\n"
                        sleep 5
                fi
		aplay -l | grep 'USB Sound Device' |grep 'USB_Left_UP'
                if [ $? -eq 0 ];
			then
			USB_Left_Up=true
                        timeout 5s alsa_out -d hw:USB_Left_UP
                        sudo darkice -c /home/pi/Desktop/USB_Left_UP.cfg &
			pid_one=$!
			printf "\r\n$pid_one....\r\n$USB_Left_Up.....\r\nUsb 1.....\r\n"
                        sleep 5

                fi
		aplay -l | grep 'USB Sound Device' |grep 'USB_Left_DOWN'
                if [ $? -eq 0 ];
			then
			USB_Left_Down=true
                        timeout 5s alsa_out -d hw:USB_Left_DOWN
                        sudo darkice -c /home/pi/Desktop/USB_Left_DOWN.cfg &
			pid_two=$!
			printf "\r\n$pid_two....\r\n$USB_Left_Down.....\r\nUsb 2.....\r\n"
                        sleep 5
                fi
	fi
else
if [ $firstrun -eq 0 ]
	then
	firstrun=1
	sudo kill $pid_one
	sudo kill $pid_two
	sudo kill $pid_tree
	sudo kill $pid_four
	USB_Left_Up=false
	USB_Left_Down=false
	USB_Right_Up=false
	USB_Right_Down=false

fi
fi
sleep 10
done
