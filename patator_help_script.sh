#!/bin/bash

for f in $1/*
do
	if [[ $f = *".txt" ]]
	then
		if ! [[ $(cat "$f" | grep "$2") ]]
		then
			echo "$f"
			cat "$f" | grep "$2"
			echo "Your good credentials are in test number: "; echo "$f" | cut -d_ -f1 -
		fi
	fi
done