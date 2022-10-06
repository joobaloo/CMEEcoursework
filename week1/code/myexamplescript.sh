#!/bin/sh
#Author: Jooyoung Ser zs519@imperial.ac.uk
#Script: myexamplescript.sh
#Desc: introducing the $USER/$USERNAME environmental variable
#Arguments: none
#Date: 05/10/2022

MSG1='hello'
MSG2=$USER
echo "$MSG1 $MSG2"
echo "sup $MSG2"
echo