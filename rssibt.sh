#!/bin/bash

temporary_path="./bt_RSSI_temporary.txt"
output_path="./bt_RSSI_output.txt"

test -f $temporary_path && rm $temporary_path
test -f $output_path && rm $output_path

addr=$(hcitool con | awk '{print $3}')
cmd="sudo hcitool rssi"
cmd=$cmd$addr

echo $1' medidas a serem realizadas'

n=1
while [ $n -le $1 ]
do
        echo $cmd | bash >> $temporary_path
        echo 'Realizando Medida '$n
        sleep 1s
        ((n=$n+1))
        tput cuu1
        tput el
done

echo 'Bluetooth RSSI [dbm]' >> $output_path
fgrep -w RSSI $temporary_path | awk '{print $NF}' >> $output_path

rm $temporary_path
echo "Medidas finalizadas!"
