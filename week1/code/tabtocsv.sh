#!/bin/sh
#Author: Jooyoung Ser zs519@imperial.ac.uk
#Script: tabtocsv.sh
#Desc: useful shell-scripting examples and substituting all tabs with commas
#Arguments: none
#Date: 05/10/2022

#error message when no input files provided
if [ $# -eq 0 ]; then
    echo "No arguments provided, this script requires one input file"
    exit 
fi

#creating comma delimited version of input file
echo "creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv

echo "Done! A new .csv file has been created"
exit