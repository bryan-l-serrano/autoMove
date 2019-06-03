#!/bin/bash
#Bryan Serrano
#automove.sh
#April 23, 2019

#test number of inputs from user
#if no inputs, then explain the use of automove.sh
#if 2 inputs, assign input to variables and copy files to second location
#on the same machine
#if 4 inputs, assign input to variables and copy files to second locatio on a different machine on the same network
if [ $# -eq 0 ]; then
	#inform users of proper usage when 
	echo "Usage: $0 targetDirectory destinationDirectory"
	echo "Usage: $0 targetDirectory UsernameAtHostMachine DestinationIP Destinationdirectory"
	exit 1
elif [ $# -eq 2 ]; then
	dir1=$1
	dest=$2

	if [ $dir1 -eq $dest ]; then
		echo "Target and destination must be different"
		exit 1
	fi	

	inotifywait -m $dir1 -e create -e moved_to |
	while read path action file; do
		cp $dir1/$file $dest/$file
	done
elif [ $# -eq 4 ]; then
	dir1=$1
	username=$2
	destIP=$3
	dest=$4

	inotifywait -m $dir1 -e create -e moved_to |
	while read path action file; do
		scp $dir1/$file $username@$destIP:$dest
	done
	
fi


