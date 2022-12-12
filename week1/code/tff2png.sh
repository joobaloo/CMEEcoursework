#!/bin/bash
#Author: Jooyoung Ser zs519@imperial.ac.uk
#Script: tabtocsv.sh
#Desc: Shell script that converts .tif files to .png files
#Arguments: none
#Date: Oct 2022

#error message when no input files provided
if [ $# -eq 0 ]; then
    echo "No arguments provided, this script requires one input file"
    exit 
fi

#converting file type
for f in *.tif; 
    do  
        echo "Converting $f"; 
        convert "$f"  "$(basename "$f" .tif).png"; 
    done

