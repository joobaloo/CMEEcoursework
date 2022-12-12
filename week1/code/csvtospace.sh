#!/bin/sh
#Author: Jooyoung Ser zs519@imperial.ac.uk
#Script: csvtospace.sh
#Desc: shell script that converts comma separated values to space separated values (Creating a new file)
#Arguments: none
#Date: 05/10/2022

#error message for no inputs provided
if [ $# -eq 0 ]; then
    echo "No arguments provided, this script requires one input file"
    exit 1
fi

#creating a space separated file
echo "creating a space separated version of $1 ..."
cat $1 | tr -s "," " " >> $1.txt
echo "Done!"
exit