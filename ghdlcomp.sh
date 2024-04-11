#!/bin/bash

runtime=10ns

while IFS= read -r line
do
	echo "Evaluate $line"
	arr=($line)
	ghdl -a --std=08 ${arr[0]} 
	if [ -n "${arr[1]}" ]
		then 
			echo "Compile $line"
			ghdl -e --std=08 ${arr[1]}
	fi
	if [ -n "${arr[2]}" ]
		then 
			runtime=${arr[2]}
			echo "Running $line"
			ghdl -r --vcd=run.vcd --stop-time=$runtime ${arr[2]}
	fi
done < complist.txt
#gtkwave run.vcd

