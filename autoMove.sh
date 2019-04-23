#!/bin/bash
#Bryan Serrano
#automove.sh
#April 23, 2019

#test number of inputs from user
#if no inputs, then explain the use of automove.sh
#if 2 inputs, assign input to variables
if [ $# -eq 0 ]; then
	echo "Usage: $0 targetDirectory destinationDirectory"
	echo "targetDirectory is the directory you want to copy from"
	echo "destinationDirectory is the directory you want to copy to"
	exit 1
elif [ $# -eq 2 ]; then
	dir1=$1
	dest=$2
fi

#makes sure that the two directories are different
if [ $dir1 -eq $dest ]
	echo "Target and destination must be different"
	exit 1
fi

#sets up 'listener' on target directory
#if a new file is found in the directory
#copies file to target directory
inotifywait -m $dir1 -e create -e moved_to |
	while read path action file; do
		cp $dir1/$file $dest/$file
	done

