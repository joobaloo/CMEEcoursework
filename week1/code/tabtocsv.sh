#!/bin/sh
#Author: Jooyoung Ser zs519@imperial.ac.uk
#Script: tabtocsv.sh
#Desc: useful shell-scripting examples and substituting all tabs with commas
#Arguments: none
#Date: 05/10/2022

#echo "remove       excess   spaces." | tr -s " " #tr is abbrevation of translate/transliterate
#echo "remove all the a's" | tr -d "a"
#echo "set to uppercase" | tr [:lower:] [:upper:]
#echo "10.00 only numbers 1.33" | tr -d [:alpha:] | tr -s " " ","

if [ $# -eq 0 ]; then
    echo "No arguments provided, this script requires one input file"
    exit 1
fi

echo "creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv

echo "Done! A new .csv file has been created"
exit