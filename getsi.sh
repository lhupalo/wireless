#!/bin/bash

temporary_path="./RSSI_temporary.txt"
output_path="./RSSI_output.txt"

test -f $temporary_path && rm $temporary_path
test -f $output_path && rm $output_path

network=$(ip addr show | awk '/inet.*brd/{print $NF; exit}')
cmd="iwconfig "
cmd=$cmd$network

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

echo 'RSSI [dbm]' >> $output_path
fgrep -w Signal $temporary_path | awk 'BEGIN{FS = "level=";} {print $NF;}' | awk '{print $1}' >> $output_path

rm $temporary_path
echo "Medidas finalizadas!"
