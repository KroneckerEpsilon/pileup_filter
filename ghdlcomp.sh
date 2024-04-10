#!/bin/bash

runtime=10ns

while IFS= read -r line
do
	arr = ($line)
	ghdl -a ${arr[0]}
	if [[-n "${arr[1]}"]]
		then 
		ghdl -e ${arr[1]}
	fi
	if [[-n "${arr[2]}"]]
		then runtime=${arr[2]}
		ghdl -r $2 --vcd=run.vcd --stop-time=$runtime
	fi
done < complist.txt
gtkwave run.vcd 
