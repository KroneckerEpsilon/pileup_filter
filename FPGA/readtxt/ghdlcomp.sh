#!/bin/bash

runtime=10ns

if ["$#" -eq "3"]
	then runtime=$3
fi

ghdl -a $1
ghdl -e $2 
ghdl -r $2 --vcd=run.vcd --stop-time=$runtime

gtkwave run.vcd 
