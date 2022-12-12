#!/bin/bash
#Author: Jooyoung Ser zs519@imperial.ac.uk
#Script: compilelatex.sh
#Desc: script to count number of lines in a file
#Date: Oct 2022

#error message in the case of no input files
if [ $# -eq 0 ]
then
echo "No input file provided"
exit
fi

#counting the printing number of lines
NumLines=`wc -l < $1`
echo "The file $1 has $NumLines line(s)"

