#!/bin/bash

name=$(7z l content.gzip | grep "Name" -A 2 | awk 'FNR == 3 {print $6}')
7z x content.gzip > /dev/null 2>&1

while true; do
	7z l $name > /dev/null 2>&1
	
	if [ "$(echo $?)" == "0" ]; then 
		next=$(7z l $name | grep "Name" -A 2 | tail -n 1 | awk 'NF{print $NF}')
		7z x $name > /dev/null 2>&1 && name=$next
	else
		cat $name | awk 'NF{print $NF}'
		rm data* 
		exit 1
	fi
done


