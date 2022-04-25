#!/bin/bash

temporary_path="./bt_RSSI_temporary.txt"
output_path="./bt_RSSI_output.txt"

test -f $temporary_path && rm $temporary_path
test -f $output_path && rm $output_path

cmd="sudo btmgmt find"
cmd=$cmd

echo $1' medidas a serem realizadas'

n=1
while [ $n -le $1 ]
do
	tmp=$(eval "$cmd")
	echo "$tmp" >> $temporary_path
        echo 'Realizando Medida '$n
        sleep 3s
        ((n=$n+1))
        tput cuu1
        tput el
done

echo 'Bluetooth RSSI [dbm]' >> $output_path
fgrep -w "EDR rssi" $temporary_path | awk '{print $7}' >> $output_path

rm $temporary_path
echo "Medidas finalizadas!"
