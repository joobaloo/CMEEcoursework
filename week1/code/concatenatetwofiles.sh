#!/bin/bash
if [ $# -eq 0 ]; then
    echo "No arguments provided, this script requires two input files"
    exit 1
fi

cat $1 > $3
cat $2 >> $3
echo "Merged file is"
cat $3
echo "the file has been saved into the results folder"
mv $3 ../results/