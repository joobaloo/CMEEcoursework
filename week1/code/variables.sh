#!/bin/sh
#Author: Jooyoung Ser zs519@imperial.ac.uk
#Script: variables.sh
#Desc: illustrating the use of variables
#Arguments: none
#Date: 05/10/2022

#special variables
echo "this script was called with $# parameters"
echo "this script's name is $0"
echo "the arguments are $@"
echo "the first argument is $1"
echo "the second argument is $2"

#assigned variables - explicit declaration
MY_VAR='some string'
echo 'the current value of the variable is:' $MY_VAR
echo 
echo 'please enter a new string'
read MY_VAR
echo
echo 'the current value of the variable is:' $MY_VAR
echo

#assigned variables - reading (multiple values) from user input
echo 'enter two numbers separated by a space'
read a b
echo
echo 'you entered' $a 'and' $b 'their sum is:'

#assigned variables; command substitution
MY_SUM=$(expr $a + $b) 
echo $MY_SUM



